class UrlController < ApplicationController

  def show
    mini_url = params[:mini_url]
    return unless mini_url
    model = URL.find_by(mini_url: mini_url)
    model.visit_count += 1
    model.save
    redirect_to(model.full_url)
  end

  def create
    full_url = params[:full_url]
    return unless full_url
    model = URL.find_by(full_url: full_url)
    model ||= URL.new(full_url)
    model.save
    render json: { full_url: full_url, mini_url: model.mini_url }
  end
end
