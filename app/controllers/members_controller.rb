class MembersController < ApplicationController

 def show_me
    user = get_user_from_token
    hosted_meals = Meal.all.where(host_id: user.id)
    guested_meals = Attendance.where(user: User.find(user.id))
    user = get_user_from_token
    arrayMessage = Message.all.where( recipient: user).or(Message.all.where(sender: user))
    arrayUniq = []
    arrayMessage = arrayMessage.map { |m|
        arrayUniq << m.sender
        arrayUniq << m.recipient
     }

     arrayUniq.delete_if { |h| h[:id] == user.id }
     arrayUniq.uniq! {|e| e[:id] }

    current_user_written_reviews = Review.all.where(host: user)
    current_user_received_reviews = Review.all.where(author: user)

    render json: {
      user: UserSerializer.new(user).serializable_hash[:data][:attributes],
      hosted_meals: hosted_meals.map{|meal|
        MealSerializer.new(meal).serializable_hash[:data][:attributes]
      },
      list_chatters: arrayUniq,
      guested_meals: guested_meals.map{|meal|
        MealSerializer.new(meal.meal).serializable_hash[:data][:attributes]
      },
      reviews: {
        written: current_user_written_reviews.map{|review|
            {
               review_content: ReviewSerializer.new(review).serializable_hash[:data][:attributes],
               author_avatar: UserSerializer.new(review.author).serializable_hash[:data][:attributes][:avatar_url]
          }
        },
        received: current_user_received_reviews.map{|review|
            {
                review_content: ReviewSerializer.new(review).serializable_hash[:data][:attributes],
                author_avatar: UserSerializer.new(review.author).serializable_hash[:data][:attributes][:avatar_url]
             }
         },
      }
    }
  end

  def update_me
    user = get_user_from_token
    if user.update(user_params)
        render json: UserSerializer.new(user).serializable_hash[:data][:attributes]
    else
        render json: user.errors, status: :unprocessable_entity
    end
  end

  def index
    @users = User.all
    render json: @users.map{|user|
        UserSerializer.new(user).serializable_hash[:data][:attributes]
        }
  end

  def show_user
    @user = User.find(params[:id])
    render json: UserSerializer.new(@user).serializable_hash[:data][:attributes]
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :age, :description, :city, :gender, :avatar)
    end

  def get_user_from_token
    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], ENV["JWT_SECRET_KEY"]).first
    user_id = jwt_payload['sub']
    User.find(user_id.to_s)
  end
end