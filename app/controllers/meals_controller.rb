class MealsController < ApplicationController
  before_action :set_meal, only: %i[ show update destroy ]
  before_action :authenticate_user!, only: %i[create]

  # GET /meals
  def index
    @meals = Meal.all
    categories = Category.all
    
    @meals.each do |meal|
      meal.update(image_url: meal.image_url)
    end

    render json: @meals.as_json(include: [host: {only: :name}, categories: {only: :label}])
  end

  # GET /meals/1
  def show
    puts "#"*50
    puts "SHOW =>", @meal.images.attach(params[:images])
    puts "#"*50

    @meal.update(image_url: @meal.image_url)
 
    guests = Attendance.where(meal_id: @meal.id)
    render json: @meal.as_json(include: [:host, guests: {only: :name}])
    # render json: MealSerializer.new(@meal).serializable_hash[:data][:attributes]
    
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

  end

  # PATCH/PUT /meals/1
  def update
    # puts "#"*50
    # puts "update_meal =>", @meal
    # puts "#"*50

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
      render json: @meal.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      # puts "#"*50
      # puts "set_meal =>", params
      # puts "#"*50
      @meal = Meal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meal_params
      params.require(:meal).permit(:title, :description, :price, :guest_capacity, :guest_registered, :starting_date, {location: [:city, :lat, :lon, :address]}, :animals, :alcool, :doggybag, :theme, allergens: [], diet_type: [], images: [])
    end

    
end
