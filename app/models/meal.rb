class Meal < ApplicationRecord
   has_many :attendances, dependent: :delete_all
   has_many :users, through: :attendances

   belongs_to :host, :class_name => "User"
   has_many :joinCategoryMeals
   has_many :categories, through: :joinCategoryMeals
   has_many_attached :images

   validates :starting_date, comparison: { greater_than: Date.yesterday }, presence: true
   validates :description, length: { maximum: 500 }, presence: true
   validates :guest_capacity, numericality: { only_integer: true }, comparison: { greater_than: 0, less_than: 12 }, presence: true
   validates :title, length: { maximum: 50, minimum: 1 }, presence: true
   validates :price, comparison: { greater_than: 0, less_than: 25 }, presence: true

   def image_urls
     images.map{|image| Rails.application.routes.url_helpers.url_for(image) } if images.attached?
   end
end
