class MembersController < ApplicationController
  before_action :authenticate_user!, only: %i[show_me, update_me]


  def show_me
    user = get_user_from_token
    render json: UserSerializer.new(user).serializable_hash[:data][:attributes]
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
        user.as_json(include: :hosted_meals)
        }
  end


  def show_user
    @user = User.find(params[:id])
    render json: @user.as_json(include: :hosted_meals)
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