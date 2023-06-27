require_relative '../../lib/extensions/float'

RSpec.describe Extensions::Float do
  let(:subject) { ->(float) { float.nearest_step(step) } }

  describe "Correctly round to nearest step" do
    context "when step is 0.05" do
      let(:step) { 0.05 }
      
      it('rounds zero to zero') { expect(subject.call(0.00)).to eq(0.00) }

      context 'when values less than nearest step' do 
        it('does not round number with 2 decimals') { expect(subject.call(0.010)).to eq(0.01) }
        it('go to nearest step when rounding down') { expect(subject.call(0.011)).to eq(0.05) }
        it('go to nearest step when rounding down') { expect(subject.call(0.012)).to eq(0.05) }
        it('go to nearest step when rounding down') { expect(subject.call(0.013)).to eq(0.05) }
        it('go to nearest step when rounding down') { expect(subject.call(0.014)).to eq(0.05) }
        it('go to nearest step when third decimal is equal 5') { expect(subject.call(0.015)).to eq(0.05) }
        it('regular round number when round is above nearest step') { expect(subject.call(0.016)).to eq(0.02) }
        it('regular round number when round is above nearest step') { expect(subject.call(0.017)).to eq(0.02) }
        it('regular round number when round is above nearest step') { expect(subject.call(0.018)).to eq(0.02) }
        it('regular round number when round is above nearest step') { expect(subject.call(0.019)).to eq(0.02) }
      end

      context 'when nearest step increment first decimal' do
        it('does not round number with 2 decimals') { expect(subject.call(0.090)).to eq(0.09) }
        it('go to nearest step when rounding down') { expect(subject.call(0.091)).to eq(0.1) }
        it('go to nearest step when rounding down') { expect(subject.call(0.092)).to eq(0.1) }
        it('go to nearest step when rounding down') { expect(subject.call(0.093)).to eq(0.1) }
        it('go to nearest step when rounding down') { expect(subject.call(0.094)).to eq(0.1) }
        it('go to nearest step when third decimal is equal 5') { expect(subject.call(0.095)).to eq(0.1) }
        it('regular round number when round is above nearest step') { expect(subject.call(0.096)).to eq(0.1) }
        it('regular round number when round is above nearest step') { expect(subject.call(0.097)).to eq(0.1) }
        it('regular round number when round is above nearest step') { expect(subject.call(0.098)).to eq(0.1) }
        it('regular round number when round is above nearest step') { expect(subject.call(0.099)).to eq(0.1) }  
      end

      context 'valid with given answers' do
        it('Given answer 1') { expect(subject.call(16.489)).to eq(16.49) }
        it('Given answer 3') { expect(subject.call(32.1885)).to eq(32.19) }
        it('Given answer 4') { expect(subject.call(20.889)).to eq(20.89) }
        it('Given answer 5') { expect(subject.call(11.8125)).to eq(11.85) } 
        it('Given answer 2') { expect(subject.call(54.625)).to eq(54.65) }
        it('Given answer 1') { expect(subject.call(9.99)).to eq(9.99) }
      end
    end

    context "when step is 0.5" do
      let(:step) { 0.5 }
      
      context 'when values less than nearest step' do 
        it('does not round number with 2 decimals') { expect(subject.call(0.10)).to eq(0.1) }
        it('go to nearest step when rounding down') { expect(subject.call(0.11)).to eq(0.5) }
        it('go to nearest step when rounding down') { expect(subject.call(0.12)).to eq(0.5) }
        it('go to nearest step when rounding down') { expect(subject.call(0.13)).to eq(0.5) }
        it('go to nearest step when rounding down') { expect(subject.call(0.14)).to eq(0.5) }
        it('go to nearest step when third decimal is equal 5') { expect(subject.call(0.15)).to eq(0.5) }
        it('regular round number when round is above nearest step') { expect(subject.call(0.16)).to eq(0.2) }
        it('regular round number when round is above nearest step') { expect(subject.call(0.17)).to eq(0.2) }
        it('regular round number when round is above nearest step') { expect(subject.call(0.18)).to eq(0.2) }
        it('regular round number when round is above nearest step') { expect(subject.call(0.19)).to eq(0.2) }
      end
    end
  end
end