class Meal < ApplicationRecord
   has_many :attendances
   has_many :guests, through: :attendances, :class_name => "User"
   belongs_to :host, :class_name => "User"
   has_many :joinCategoryMeals
   has_many :categories, through: :joinCategoryMeals
   has_many_attached :images

   validates :starting_date, comparison: { greater_than: Date.today }, presence: true
   validates :description, length: { maximum: 500 }, presence: true
   validates :guest_capacity, numericality: { only_integer: true }, comparison: { greater_than: 0, less_than: 12 }, presence: true
   validates :title, length: { maximum: 16, minimum: 4 }, presence: true
   validates :price, numericality: { only_integer: true }, comparison: { greater_than: 0, less_than: 25 }, presence: true
   validates :image_urls, length: { minimum: 2}

   def image_urls
     images.map{|p| Rails.application.routes.url_helpers.url_for(p) }
   end
end
