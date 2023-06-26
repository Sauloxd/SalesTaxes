module ProductCategories
  class Categories
    def self.has?(name)
      list.include?(name)
    end
  end
end