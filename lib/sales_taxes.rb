class SalesTaxes
  DEFAULT_TAX_CONFIG = {
    exempt: [:book, :food, :medical_product],
    default: 10,
    importation: 5,
    step: 0.05,
  }

  def initialize(config = nil)
    @config = config || DEFAULT_TAX_CONFIG
  end

  def tax_product(product)
    tax = @config[:default]
    tax = 0 if exempt?(product)
    tax += @config[:importation] if product.imported?
    tax = (tax + 100)/100.to_f

    unrounded_price = tax * product.price.to_f
    unrounded_price.nearest_step(@config[:step]) * product.quantity
  end

  private

  def exempt?(product) 
    @config[:exempt].include?(product.type)
  end
end
