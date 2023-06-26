require_relative './data_parser_line'

class DataParser
  def parse(raw_input)
    raw_input
      .split("\n")
      .map { |line| DataParserLine.new(line).parse }
      .compact
  end
end