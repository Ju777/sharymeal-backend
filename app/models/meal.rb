class Meal < ApplicationRecord

   has_many :attendances
   has_many :guests, through: :attendances, :class_name => "User"
   belongs_to :host, :class_name => "User"

   has_many :joinCategoryMeals
   has_many :categories, through: :joinCategoryMeals

   has_many_attached :images

   def image_url
      # puts "#"*50
      # puts 'images => ', images.count
      # puts "#"*50
      Rails.application.routes.url_helpers.url_for(images) if images.attached?
   end
end
