class ChargesController < ApplicationController
  before_action :authenticate_user!, only: %i[create]

  def create
    # puts "#"*100
    # puts "\n user_signed_in?", user_signed_in?
    # puts "\n current_user", current_user.id
    # puts "\n requester", params[:requester][:id]
    # puts "#"*100

    # if params[:requester][:id] === current_user.id
    if IsAccountOwner.new(params[:requester][:id]).is_owner?
    #   puts "#"*100
    # puts "c'est toi"
    # puts "#"*100
      Stripe.api_key = ENV['SECRET_KEY']

      payment_intent = Stripe::PaymentIntent.create(
        amount: params[:amount],
        currency: params[:charge][:currency],
        automatic_payment_methods: {
          enabled: true,
        },
      )
    #  puts payment_intent
      render json: {
        clientSecret: payment_intent["client_secret"],
      }

    else
    #   puts "#"*100
    # puts "c'est pas toi"
    # puts "#"*100
      render json: {
        account_owner: false,
        message:"The account's owner authentication failed."
      }
    end
  end
end
