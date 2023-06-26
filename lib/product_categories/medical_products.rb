require_relative './categories'

module ProductCategories
  class MedicalProducts < Categories
    def self.list
      ["packet of headache pills"]
    end
  end
end