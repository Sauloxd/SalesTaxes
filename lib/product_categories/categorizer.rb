require_relative "./foods"
require_relative "./books"
require_relative "./medical_products"

module ProductCategories
  CATEGORIES = [:other, :book, :food, :medical_product]
  
  class Categorizer
    def self.categorize(name)
      type = :other
      type = :book if Books.has?(name)
      type = :food if Foods.has?(name)
      type = :medical_product if MedicalProducts.has?(name)

      type
    end
  end
end