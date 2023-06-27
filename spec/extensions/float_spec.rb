require_relative '../../lib/extensions/float'

RSpec.describe Extensions::Float do
  let(:subject) { ->(float) { float.nearest_step(step) } }

  describe "Correctly round to nearest step" do
    context "when step is 0.05" do
      let(:step) { 0.05 }
      
      it('rounds zero to zero') { expect(subject.call(0.00)).to eq(0.00) }
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

      it('rounds third decimal to nearest 0.05') { expect(subject.call(9.914)).to eq(9.95) }

      # Round normally when 2nd decimal is greather than 5
      it('Given answer 1') { expect(subject.call(16.489)).to eq(16.49) }
      it('Given answer 3') { expect(subject.call(32.1885)).to eq(32.19) }
      it('Given answer 4') { expect(subject.call(20.889)).to eq(20.89) }
      # Round to next 0.05 when 2nd decimal is less than 5
      it('Given answer 5') { expect(subject.call(11.8125)).to eq(11.85) } # round even if value is 11.81
      it('Given answer 2') { expect(subject.call(54.625)).to eq(54.65) } # round because 54.63 -> closer to 54.65
      # Do not round when exactly 2 decimals
      it('Given answer 1') { expect(subject.call(9.99)).to eq(9.99) }
    end
  end
end