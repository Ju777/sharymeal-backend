class Meal < ApplicationRecord
   has_many :attendances
   has_many :guests, through: :attendances, :class_name => "User"
   belongs_to :host, :class_name => "User"
   has_many :joinCategoryMeals
   has_many :categories, through: :joinCategoryMeals
   has_many_attached :images

   validates :starting_date, comparison: { greater_than: Date.yesterday }, presence: true
   validates :description, length: { maximum: 500 }, presence: true
   validates :guest_capacity, numericality: { only_integer: true }, comparison: { greater_than: 0, less_than: 12 }, presence: true
   validates :title, length: { maximum: 36, minimum: 1 }, presence: true
   validates :price, comparison: { greater_than: 0, less_than: 25 }, presence: true

   def image_urls
    puts "#"*100
    # puts images.methods
    puts Rails.application.routes.methods
    puts "#"*100

     images.map{|image| Rails.application.routes.url_helpers.url_for(image) } if images.attached?
   end
end
