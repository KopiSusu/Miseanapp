class Amount < ActiveRecord::Base
  belongs_to :ingredient

  # validates :quantity, :numericality => { :greater_than => 0 }
end
