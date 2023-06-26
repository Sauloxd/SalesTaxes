require_relative '../lib/sales_taxes'
require_relative '../lib/product'
require 'pry'

RSpec.describe SalesTaxes do
  let(:subject) { described_class.new.tax_product(product) }
  describe "Calculate tax product" do
    context 'with varying quantity' do
      let(:product) { Product.new(
        imported: false, type: :book, quantity: 2, name: 'book', price: 12.49
      ) }
      it 'calculates final_price' do
        expect(subject).to eq(24.98)
      end
    end

    context 'with rounding needed' do
      let(:product) { Product.new(
        imported: false, type: :other, quantity: 1, name: 'bottle of perfume', price:  18.99
      ) }
      it 'calculates final_price' do
        expect(subject).to eq(20.89)
      end
    end

    context 'with imported taxable product' do
      let(:product) { Product.new(
        imported: true, type: :other, quantity: 1, name: 'bottle of perfume', price:  47.50
      ) }
      it 'calculates final_price' do
        expect(subject).to eq(54.65)
      end
    end

    context 'with imported taxable product' do
      let(:product) { Product.new(
        imported: true, type: :food, quantity: 3, name: 'boxes of chocolates', price: 11.25
      ) }
      it 'calculates final_price' do
        expect(subject).to eq(35.55)
      end
    end

    context 'with imported taxable product' do
      let(:product) { Product.new(
        imported: true, type: :food, quantity: 1, name: 'box of chocolates', price: 10.00
      ) }
      it 'calculates final_price' do
        expect(subject).to eq(10.50)
      end
    end
  end
end