class MealsController < ApplicationController
  before_action :set_meal, only: %i[ show update destroy ]
  before_action :authenticate_user!, only: %i[create]

  # GET /meals
  def index
    @meals = Meal.all

    render json: @meals.as_json(include: :host)
  end

  # GET /meals/1
  def show
    render json: @meal.as_json(include: :host)
  end

  # POST /meals
  def create
    @meal = Meal.new(meal_params)
    @meal.host = current_user

    if @meal.save
      render json: @meal, status: :created, location: @meal
    else
      render json: @meal.errors, status: :unprocessable_entity
    end

    puts "#"*100
    puts @meal.allergens.length
  end

  # PATCH/PUT /meals/1
  def update
    if @meal.host_id === current_user.id && @meal.update(meal_params)
      render json: @meal
    else
      render json: @meal.errors, status: :unprocessable_entity
    end
  end

  # DELETE /meals/1
  def destroy
    if (@meal.host_id === current_user.id )
      @meal.destroy
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = Meal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meal_params
      params.require(:meal).permit(:title, :description, :price, :guest_capacity, :guest_registered, :starting_date, {location: [:city, :lat, :lon, :address]}, :animals, :alcool, :doggybag, :theme, allergens: [], diet_type: [])
    end
end
