class JoinCategoryMeal < ApplicationRecord
    belongs_to :category
    belongs_to :meal
end
