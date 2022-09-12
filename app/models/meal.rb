class Meal < ApplicationRecord

   has_many :attendances
   has_many :guests, through: :attendances, :class_name => "User"
   belongs_to :host, :class_name => "User"
end
