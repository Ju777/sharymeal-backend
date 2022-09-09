class UserMailer < Devise::Mailer
  default from: "sharymeal@yopmail.com" 

 
  def reset_password_instructions(record, token, opts={})
    super
  end
 
 end
