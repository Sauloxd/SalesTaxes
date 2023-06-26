# Get data input
require 'pry'

class SalesTaxes
  def args
    print <<~HEREDOC
      Add your products in the following structure:
      [type?: imported] [quantity: string] [product_name: string] at [princing: float]

      Example:
      1 imported bottle of perfume at 27.99
      1 bottle of perfume at 18.99

    HEREDOC
    
    args = gets
  end 

  def parse(raw_input)
    raw_input
      .split("\n")
      .map { |x| x.lstrip.rstrip }
      .filter {|x| !x.empty?}
      .map do |line|
        price = line.scan(/ at [0-9]+\.[0-9]+/)[0].gsub(" at ", "").to_f
        description_tokens = line.split(/ at [0-9]+\.[0-9]+/)[0].split(/\s/)
        quantity = description_tokens[0].to_i
        imported = description_tokens[1] == "imported"
        name = imported ? description_tokens.slice(2..).join(" ") : description_tokens.slice(1..).join(" ")
        type = :other
        type = :book if books.include?(name)
        type = :food if foods.include?(name)
        type = :medical_product if medical_products.include?(name)
        {
          type: type,
          quantity: quantity,
          imported: imported,
          name: name,
          price: price,
        }
      end
  end

  def books
    ["book"]
  end
  def foods
    ["chocolate bar", "boxes of chocolates", "box of chocolates"]
  end
  def medical_products
    ["packet of headache pills"]
  end
end

# SalesTaxes.new.args