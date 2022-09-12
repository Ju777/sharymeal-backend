class Category < ApplicationRecord
    has_many :joinCategoryMeals
    has_many :meals, through: :joinCategoryMeals
end
