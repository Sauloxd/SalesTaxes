
class Product
  attr_reader :name, :price, :final_price, :tax_costs, :type, :quantity

  def initialize(**args)
    @type = args[:type]
    @quantity = args[:quantity]
    @imported = args[:imported]
    @name = args[:name]
    @price = args[:price]
    @final_price = args[:final_price]
  end

  def imported?
    @imported
  end

  def final_price
    @final_price ||= SalesTaxes.new.tax_product(self)
  end

  def tax_costs
    (@final_price - (@price * @quantity)).round(2)
  end
end

