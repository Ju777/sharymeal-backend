class User < ApplicationRecord
	# Il faut ajouter les deux modules commençant par jwt
	devise :database_authenticatable, :registerable, :recoverable,
	:jwt_authenticatable,
	jwt_revocation_strategy: JwtDenylist

	has_many :attendances
	has_many :hosted_meals, :class_name => "Meal", :foreign_key => "host_id"
	has_many :guested_meals, through: :attendances, :class_name => "Meal"
	has_one_attached :avatar

	validates :name, length: { maximum: 15 }
	validates :email, length: { maximum: 45 }, presence: true
	validates :description, length: { maximum: 500 }
	validates :age, numericality: { only_integer: true }, comparison: { greater_than: 16, less_than: 99 }



	def avatar_url
        Rails.application.routes.url_helpers.url_for(avatar) if avatar.attached?
    end
end
