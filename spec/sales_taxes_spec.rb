require_relative '../lib/sales_taxes'

RSpec.describe SalesTaxes do
  describe "Collect arguments" do
    context "with single line parameters" do 
      [
        ['2 book at 12.49', { imported: false, type: :book, quantity: 2, name: 'book', price: 12.49} ],
        ['1 music CD at 14.99', { imported: false, type: :other, quantity: 1, name: 'music CD', price: 14.99} ],
        ['1 chocolate bar at 0.85', { imported: false, type: :food, quantity: 1, name: 'chocolate bar', price: 0.85 } ],
        ['1 imported box of chocolates at 10.00', { imported: true, type: :food, quantity: 1, name: 'box of chocolates', price: 10.00} ],
        ['1 imported bottle of perfume at 47.50', { imported: true, type: :other, quantity: 1, name: 'bottle of perfume', price:  47.50} ],
        ['1 imported bottle of perfume at 27.99', { imported: true, type: :other, quantity: 1, name: 'bottle of perfume', price: 27.99} ],
        ['1 bottle of perfume at 18.99', { imported: false, type: :other, quantity: 1, name: 'bottle of perfume', price:  18.99} ],
        ['1 packet of headache pills at 9.75', { imported: false, type: :medical_product, quantity: 1, name: 'packet of headache pills', price:  9.75} ],
        ['3 imported boxes of chocolates at 11.25', { imported: true, type: :food, quantity: 3, name: 'boxes of chocolates', price:11.25 } ],
      ].each do |(input, output)|
        it "#{input}" do 
          expect(described_class.new.parse(input)).to contain_exactly(output)
        end
      end
    end
    
    context "with multiline parameters" do
      let(:subject) { described_class.new.parse(input) }
      let(:input) do 
        "
          2 book at 12.49
          1 imported bottle of perfume at 47.50
          3 somethingat at 27.51
        "
      end

      it "parses imported, type, quantity and value properly" do
        expect(subject).to contain_exactly({
          imported: false,
          type: :book,
          quantity: 2,
          name: 'book',
          price: 12.49
        }, 
        {
            imported: true,
            type: :other,
            quantity: 1,
            name: 'bottle of perfume',
            price: 47.50
        },
        {
          imported: false,
          type: :other,
          quantity: 3,
          name: 'somethingat',
          price: 27.51
        })
      end
    end
  end
end