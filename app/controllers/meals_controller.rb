class MealsController < ApplicationController
  before_action :set_meal, only: %i[ show update destroy get_meal_categories]
  before_action :authenticate_user!, only: %i[create]

  # GET /meals
  def index
   
    @meals = Meal.all
    # categories = Category.all
    # render json: @meals.as_json(include: [host: {only: :name}, categories: {only: :label}])
    render json: @meals.map{|meal|
      MealSerializer.new(meal).serializable_hash[:data][:attributes]
      }
  end



  # GET /meals/1
  def show
    guests = Attendance.where(meal_id: @meal.id)
    join_category_ids = Meal.find(@meal.id).joinCategoryMeal_ids
    hosted_meals = Meal.all.where(host_id: @meal.host.id).count
    host_avatar = Meal.find(@meal.id).host
    current_user_received_reviews = Review.all.where(host: Meal.find(@meal.id).host)
    #render json: @meal.as_json(include: [:host, guests: {only: :name}])
    render json: {
        joinCategoryMealIds: join_category_ids,
        meal: MealSerializer.new(@meal).serializable_hash[:data][:attributes],
        hosted_meals: hosted_meals,
        host_avatar: UserSerializer.new(host_avatar).serializable_hash[:data][:attributes][:avatar_url],
        host_reviews: {
            received: current_user_received_reviews.map{|review|
                {
                   review_content: ReviewSerializer.new(review).serializable_hash[:data][:attributes],
                   author_avatar: UserSerializer.new(review.author).serializable_hash[:data][:attributes][:avatar_url]
              }
            },
        }
    }
  end

  def get_meal_categories
    categories = Meal.find(@meal.id).categories
    render json: categories
  end

  # POST /meals
  def create

    puts "#"*100
    puts "\nmeal_params : ", meal_params
    puts "\nstarting_date :", meal_params[:starting_date]
    
    puts "#"*100
    
    @meal = Meal.new(meal_params)
    @meal.host = current_user

    # Need to add 1 day because of a mysterious difference bewteen the date sent by React and the date created by Rails.
    @meal.starting_date += 1.days
    

    if @meal.save
      render json: @meal, status: :created, location: @meal
    else
      render json: @meal.errors, status: :unprocessable_entity
    end

  end

  # PATCH/PUT /meals/1
  def update
    #if @meal.host_id === current_user.id && @meal.update(meal_params)
    if @meal.update(meal_params)
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
