require_relative '../lib/checkout'

RSpec.describe Checkout do
  let(:subject) { described_class.new(products) }
  describe "Print summary" do
    context 'Input 1' do 
      let(:products) do
        [
          Product.new(
            imported: false, type: :book, quantity: 2, name: 'book', price: 12.49
          ),
          Product.new(
            imported: false, type: :other, quantity: 1, name: 'music CD', price: 14.99
          ),
          Product.new(
            imported: false, type: :food, quantity: 1, name: 'chocolate bar', price: 0.85
          ),
        ]
      end
      let(:output) do
        <<~HEREDOC
          2 book: 24.98
          1 music CD: 16.49
          1 chocolate bar: 0.85
          Sales Taxes: 1.50
          Total: 42.32
        HEREDOC
      end
      it 'prints expected string output' do
        expect(subject.summary).to eq(output)
      end
    end
    context 'Input 2' do 
      let(:products) do
        [
          Product.new(
            imported: true, type: :food, quantity: 1, name: 'box of chocolates', price: 10.00
          ),
          Product.new(
            imported: true, type: :other, quantity: 1, name: 'bottle of perfume', price:  47.50
          ),
        ]
      end
      let(:output) do
        <<~HEREDOC
          1 imported box of chocolates: 10.50
          1 imported bottle of perfume: 54.65
          Sales Taxes: 7.65
          Total: 65.15
        HEREDOC
      end
      it 'prints expected string output' do
        expect(subject.summary).to eq(output)
      end
    end
    context 'Input 3' do 
      let(:products) do
        [
          Product.new(
            imported: true, type: :other, quantity: 1, name: 'bottle of perfume', price: 27.99
          ),
          Product.new(
            imported: false, type: :other, quantity: 1, name: 'bottle of perfume', price: 18.99
          ),
          Product.new(
            imported: false, type: :medical_product, quantity: 1, name: 'packet of headache pills', price: 9.75
          ),
          Product.new(
            imported: true, type: :food, quantity: 3, name: 'boxes of chocolates', price: 11.25
          ),
        ]
      end
      let(:output) do
        <<~HEREDOC
          1 imported bottle of perfume: 32.19
          1 bottle of perfume: 20.89
          1 packet of headache pills: 9.75
          3 imported boxes of chocolates: 35.55
          Sales Taxes: 7.90
          Total: 98.38
        HEREDOC
      end
      it 'prints expected string output' do
        expect(subject.summary).to eq(output)
      end
    end
  end
end