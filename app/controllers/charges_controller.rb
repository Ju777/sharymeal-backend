class ChargesController < ApplicationController

  def create
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
  end
end
