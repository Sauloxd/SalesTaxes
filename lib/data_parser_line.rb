require_relative './product_categories/categorizer'

class DataParserLine
  PRICE_TOKEN = / at [0-9]+\.[0-9]+/

  def initialize(line)
    @line = line.lstrip.rstrip
  end

  def parse
    return nil if @line.empty?

    {
      type: type,
      quantity: quantity,
      imported: imported?,
      name: name,
      price: price,
    }
  end

  private

  def price 
    @line.scan(DataParserLine::PRICE_TOKEN)[0].gsub(" at ", "").to_f
  end

  def quantity
    @description_tokens[0].to_i
  end

  def imported?
    description_tokens[1] == "imported"
  end

  def name
    imported? ? 
      description_tokens.slice(2..).join(" ") : 
      description_tokens.slice(1..).join(" ")
  end

  def description_tokens
    @description_tokens ||= @line.split(DataParserLine::PRICE_TOKEN)[0].split(/\s/)
  end

  def type
    ProductCategories::Categorizer.categorize(name)
  end
end