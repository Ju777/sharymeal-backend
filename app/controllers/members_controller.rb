class MembersController < ApplicationController
  before_action :authenticate_user!, only: %i[show_me, update_me]


  def show_me
    user = get_user_from_token
    hosted_meals = Meal.all.where(host_id: user.id)
    guested_meals = Attendance.where(guest_id: User.find(user.id))

    render json: {
      user: UserSerializer.new(user).serializable_hash[:data][:attributes],
      hosted_meals: hosted_meals.as_json(include: :categories),
      guested_meals: guested_meals.as_json(include: :meal)
    }
  end

  def guested_meals
    user = get_user_from_token
    @meals = Attendance.where(guest_id: User.find(user.id))
    render json: @meals.as_json(include: :meal)
  end

  def update_me
    user = get_user_from_token
    if user.update(user_params)
        render json: user
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