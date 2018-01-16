class OrderSummary
  def initialize(items)
    @items = items
  end

  def grand_total
    return self.total + self.tax
  end

  def total
    total = 0
    (0...@items.size).each do |index|
      puts index
      total = total + @items[index].get_price
    end

    return total
  end

  def tax
    total * 0.05
  end
end

class Product
  def initialize(name, price)
    @name = name
    @price = price
  end

  def get_price
    @price
  end

  def get_name
    @name
  end
end
