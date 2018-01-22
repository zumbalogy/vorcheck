class Url < ApplicationRecord
  include ActiveModel::Model

  # table: urls
  # fields:
  #   full_url (string)
  #   mini_url (string)
  #   visit_count (integer)

  @@base_url = "https://lend.to/"

  attr_accessor :full_url
  attr_accessor :mini_url
  attr_accessor :visit_count

  validates_presence_of :full_url
  validates_presence_of :mini_url
  validates_presence_of :visit_count

  validates_uniqueness_of :mini_url
  validates_uniqueness_of :full_url # this makes the mini_url being unique easier
  validate :mini_url_is_valid?

  def mini_url_is_valid?
    # (These are all comments for the interview, not necessarily
    # comments I would put in production code.)

    # I could validate that @mini_url.length < @full_url.length
    # or that @mini_url.length < 50 or so, but if urls are turned
    # into readable ones like www.foo.com/tomato_house_tall or
    # obscure ones (like for creating a public but unguessable link)
    # of if the original url is short for some reason, or if we use up
    # a lot of possible mini_urls, things might break. would maybe
    # be better to warn when it crosses some threshold or so.
    true
  end

  def initialize(input)
    @full_url = input
    @visit_count = 0
    @mini_url = generate_mini_url(input)
  end

  def generate_mini_url(input)
    # It would be nice if this was a deterministic and
    # process, then only the original URL would need to be stored,
    # but without doing unicode crazyness like https://9m.no/ or
    # http://tinyarrows.com/ it might be hard/impossible to avoid collisions
    # while still being short.

    # NOTE: this does expose things about the original URL and when
    # the mini url was made. It should make it easy to index on though.

    # This could be shorter if a higher base was used. The url would then
    # include capital letters or some sybols or such. Bitly uses capital
    # letters and does 7 characters, where here it is 10.

    date_str = Time.now.to_i.to_s(36)
    input_str = (input.chars.map(&:ord).reduce(:+) % 1296).to_s(36)
    rand_str = (rand * 1296).to_i.to_s(36)
    @@base_url + date_str + rand_str + input_str
  end

  def save
    # This could also be done in a before_save hook
    return self.save! if self.persisted?
    rety_count = 0
    while Url.where(mini_url: @mini_url).any?
      @mini_url = generate_mini_url(@full_url)
      retry_count += 1
      raise "Error saving URL" && break if retry_count > 5
      # I am not sure what a reasonable number here is.
      # There might also be fallbacks to try. Or ways of
      # pregenerating a bank or stream of mini-urls.
    end
    self.save!
  end
end
