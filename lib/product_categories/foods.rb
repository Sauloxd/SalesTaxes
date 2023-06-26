require_relative './categories'

module ProductCategories
  class Foods < Categories
    def self.list
      ["chocolate bar", "boxes of chocolates", "box of chocolates"]
    end
  end
end