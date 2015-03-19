class Recipe < ActiveRecord::Base
  belongs_to :user

  has_many :steps, dependent: :destroy

  has_many :joinirtables
  has_many :ingredients, through: :joinirtables

  accepts_nested_attributes_for :ingredients, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true, update_only: true
  accepts_nested_attributes_for :steps, :reject_if => lambda { |a| a[:instruction].blank? }, :allow_destroy => true, update_only: true

  validates :title,
    presence: true

  def current_serving(serving)
    if serving
      return serving
    else 
      self.serving
    end
  end
end
