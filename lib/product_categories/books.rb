require_relative './categories'

module ProductCategories
  class Books < Categories
    def self.list
      ["book"]
    end
  end
end