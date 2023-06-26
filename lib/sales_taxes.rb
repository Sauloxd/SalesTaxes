class SalesTaxes
  DEFAULT_TAX_CONFIG = {
    exempt: [ :book, :food, :medical_product ],
    default: 10,
    importation: 5,
    precision: 0.05,
  }

  def initialize(config = nil)
    @config = config || DEFAULT_TAX_CONFIG
  end

  def tax_product(product)
    tax = @config[:default]
    tax = 0 if exempt?(product)
    tax += @config[:importation] if product.imported?

    unrounded_price = (tax + 100) * product.price / 100

    round_to_nearest_step(unrounded_price) * product.quantity
  end

  private

  def exempt?(product) 
    @config[:exempt].include?(product.type)
  end

  def round_to_nearest_step(number)
    rounded_number = number.round(3)
    decimal_digits = rounded_number.to_s.split('.').last
    if decimal_digits[1].to_i > 5 || decimal_digits[1].to_i == 0
      number.round(2)
    else
      decimal_digits[1] = '5'
      [rounded_number.to_s.split('.').first, decimal_digits.slice(0..1)].join('.').to_f
    end
  end
end
