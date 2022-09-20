class User < ApplicationRecord
	# Il faut ajouter les deux modules commençant par jwt
	devise :database_authenticatable, :registerable, :recoverable,
	:jwt_authenticatable,
	jwt_revocation_strategy: JwtDenylist

	has_many :attendances, :foreign_key => "user_id"
    has_many :meals, through: :attendances

	has_many :hosted_meals, :class_name => "Meal", :foreign_key => "host_id"
	has_one_attached :avatar


	def avatar_url
        Rails.application.routes.url_helpers.url_for(avatar) if avatar.attached?
    end

	 after_create :welcome_send

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end 
end
