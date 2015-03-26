require "open-uri"

class Recipe < ActiveRecord::Base
  belongs_to :user
  
  has_attached_file :photo, :styles => {  small: "150x150>", med: "350x350>", large: "500x500>" }

  has_many :steps, dependent: :destroy

  has_many :joinirtables
  has_many :ingredients, through: :joinirtables

  accepts_nested_attributes_for :ingredients, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true, update_only: true
  accepts_nested_attributes_for :steps, :reject_if => lambda { |a| a[:instruction].blank? }, :allow_destroy => true, update_only: true

  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => %w(image/jpeg image/jpg image/png)
  validates :title,
    presence: true

  def current_serving(serving)
    if serving
      return serving
    else 
      self.serving
    end
  end

  def picture_from_url(url)
    self.photo = URI.parse(url)
  end

  def self.search(search)
    if search
      where('title LIKE :search' , {:search => "%#{search}%"})
    else
      find(:all)
    end
  end

end

