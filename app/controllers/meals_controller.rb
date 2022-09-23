class MealsController < ApplicationController
  before_action :set_meal, only: %i[ show update destroy get_meal_categories get_guests_avatar_url]
  before_action :authenticate_user!, only: %i[create update destroy]

  # GET /meals
  def index
   
    @meals = Meal.all
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
    guests_avatar = Meal.find(@meal.id).users
    current_user_received_reviews = Review.all.where(host: Meal.find(@meal.id).host)
    render json: {
        joinCategoryMealIds: join_category_ids,
        meal: MealSerializer.new(@meal).serializable_hash[:data][:attributes],
        hosted_meals: hosted_meals,
        host_avatar: UserSerializer.new(host_avatar).serializable_hash[:data][:attributes][:avatar_url],
        guests_avatar: guests_avatar.map{|guest|
            UserSerializer.new(guest).serializable_hash[:data][:attributes]
        },
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


  def get_guests_avatar_url
       guests_avatar = Meal.find(@meal.id).users

       render json: {
           guests_avatar: guests_avatar.map{|guest_avatar|
                UserSerializer.new(guest_avatar).serializable_hash[:data][:attributes]
            },
       }
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

    if is_owner?(params[:meal][:requester])
      puts "*" * 100
      puts "c'est lui"
      puts "*" * 100
    

      if @meal.save
        render json: {
                        meal: @meal,
                        status: :created,
                        account_owner: true
                      }
      else
        render json: @meal.errors, status: :unprocessable_entity
      end

    else
      puts "*" * 100
      puts "c'est pas lui"
      puts "*" * 100
      render json: {
        account_owner: false,
        message:"The account's owner authentication failed."
      }
    end

  end

  # PATCH/PUT /meals/1
  def update
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
      @meal = Meal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meal_params
      params.require(:meal).permit(:title, :description, :price, :guest_capacity, :guest_registered, :starting_date, {location: [:city, :lat, :lon, :address]}, :animals, :alcool, :doggybag, :theme, :requester, allergens: [], diet_type: [], images: [])
    end

    def is_owner?(requester)
      return requester[:id] === current_user.id ? true : false 
     end
end
