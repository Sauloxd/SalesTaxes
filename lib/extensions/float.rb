require 'bigdecimal'

module Extensions
  module Float
    def nearest_step(step)
      step_size = step.decimals_size
      return self if self.decimals_size == step_size

      rounded = self.round(step_size)
      nearest_step = (self * (1/step)).ceil / (1/step).to_f

      return nearest_step if self.decimal(step_size + 1) == 5
      
      nearest_step_increments_first_decimal = rounded.decimal(step_size) > self.decimal(step_size)
      if nearest_step_increments_first_decimal
       rounded
      else
        nearest_step
      end
    end

    def decimals_size
      self.to_s.split('.').last.size
    end

    def decimal(position)
      (BigDecimal(self.to_s) * 10 ** position).to_i.digits[0]
    end
  end
end

Float.include Extensions::Float