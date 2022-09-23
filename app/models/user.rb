class User < ApplicationRecord
	after_create :welcome_send
	devise :database_authenticatable, :registerable, :recoverable,
	:jwt_authenticatable,
	jwt_revocation_strategy: JwtDenylist

	has_many :attendances
    has_many :meals, through: :attendances

	has_many :hosted_meals, :class_name => "Meal", :foreign_key => "host_id"
	has_one_attached :avatar

	has_many :sent_messages, :class_name => "Message", :foreign_key => "sender_id"
	has_many :received_messages, :class_name => "Message", :foreign_key => "recipient_id"

	has_many :written_reviews, :class_name => "Review", :foreign_key => "author_id"
	has_many :received_reviews, :class_name => "Review", :foreign_key => "host_id"


	def avatar_url
        Rails.application.routes.url_helpers.url_for(avatar) if avatar.attached?
    end

	def welcome_send
		UserMailer.welcome_email(self).deliver_now
	end 

	def test_rspec(arg)
		return arg
	end
end
