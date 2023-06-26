require_relative './data_parser'
require_relative './checkout'
require_relative './product'

class CLI
  def initialize
    @data_parser = DataParser.new
  end

  def calculate_taxes
    read_data
    print_data
  end
  
  private

  def read_data
    raw_input = File.read(ARGV[0] || "../input.txt")
    input_groups = raw_input
      .split(/^Input [0-9]+:\n/)
      .filter {|x| !x.empty?}
    @data = input_groups.map{|raw_input_items| @data_parser.parse(raw_input_items) }
  end 

  def print_data
    @data.each_with_index do |group, i|
      output = "Output #{i+1}\n"
      products = group.map {|d| Product.new(**d) }
      checkout = Checkout.new(products)
      output += checkout.summary
      print output
      print "\n"
    end
  end
end

CLI.new.calculate_taxes