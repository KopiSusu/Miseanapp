class Amount < ActiveRecord::Base
  belongs_to :ingredient

  # validates :quantity, :numericality => { :greater_than => 0 }
  
  def servingsize(number)
    if number
      newnumber = number.to_i / self.ingredient.recipes.first.serving
      wholefraction = (self.quantity * newnumber).to_fraction
    else
      wholefraction = self.quantity.to_fraction
    end
    if wholefraction[1] <= 1
      return wholefraction[0]
    end
    fraction = Rational(wholefraction[0], wholefraction[1])
    numeric_to_mixed_number(fraction)
  end

  def numeric_to_mixed_number(amount)
    amount_as_integer = amount.to_i
    if (amount_as_integer != amount.to_f) && (amount_as_integer > 0)
      fraction = amount - amount_as_integer
      "#{amount_as_integer} #{fraction}"
    else
      amount.to_s
    end
  end

end
