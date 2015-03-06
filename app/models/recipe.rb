class Recipe < ActiveRecord::Base
  belongs_to :user

  has_many :steps, dependent: :destroy

  has_many :joinirtables
  has_many :ingredients, through: :joinirtables

  accepts_nested_attributes_for :ingredients, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :steps, :reject_if => lambda { |a| a[:instruction].blank? }, :allow_destroy => true

  validates :title,
    presence: true


end
