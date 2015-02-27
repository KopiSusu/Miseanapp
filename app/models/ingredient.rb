class Ingredient < ActiveRecord::Base

  has_many :joinirtables
  has_many :recipes, through: :joinirtables

  has_many :amounts, dependent: :destroy
  accepts_nested_attributes_for :amounts, :reject_if => lambda { |a| a[:quantity].blank? }, :allow_destroy => true
end
