class ChargesController < ApplicationController
  before_action :authenticate_user!, only: %i[create]
  

  def create
     if params[:requester][:id] === current_user.id
      Stripe.api_key = ENV['SECRET_KEY']

      payment_intent = Stripe::PaymentIntent.create(
        amount: params[:amount],
        currency: params[:charge][:currency],
        automatic_payment_methods: {
          enabled: true,
        },
      )
      render json: {
        clientSecret: payment_intent["client_secret"],
      }

    else
      render json: {
        account_owner: false,
        message:"The account's owner authentication failed."
      }
    end
  end
end
