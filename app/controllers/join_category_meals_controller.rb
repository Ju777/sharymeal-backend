class JoinCategoryMealsController < ApplicationController
 # before_action :set_join_category_meal, only: %i[ show update destroy ]
  before_action :authenticate_user!, only: %i[create]


  def create
    @join_category_meal = JoinCategoryMeal.new(join_category_meal_params)

    if @join_category_meal.save
      render json: @join_category_meal
    else
      render json: @join_category_meal.errors, status: :unprocessable_entity
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_join_category_meal

    end

    # Only allow a list of trusted parameters through.
    def join_category_meal_params
      params.require(:join_category_meal).permit(:meal_id, :category_id)
    end
end
