class UserMailer < Devise::Mailer
  default from: "sharymeal@yopmail.com" 

 
  def welcome_email(user)
    @user = user 

    @url  = 'https://shary-meal-front.vercel.app/' 

    mail(to: @user.email, subject: 'Bienvenue chez nous !') 
  end

  def reset_password_instructions(record, token, opts={})
    super
  end
 
 end
