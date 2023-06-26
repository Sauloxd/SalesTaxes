require_relative './sales_taxes'
require_relative './product'

class Checkout
  def initialize(products)
    @products = products
  end

  def summary
    output = ""
    @products.each do |product|
      output += "#{product.quantity} #{product.imported? ? 'imported ' : ''}#{product.name}: #{format('%.2f', product.final_price)}\n"
    end
    sales_taxes = @products.sum(&:tax_costs)
    total = @products.sum(&:final_price)
    output += "Sales Taxes: #{format('%.2f', sales_taxes)}\n"
    output += "Total: #{format('%.2f', total)}\n"
    output
  end

  def print_summary
    print summary
  end

  private
  
end