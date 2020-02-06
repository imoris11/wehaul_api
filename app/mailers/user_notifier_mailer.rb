class UserNotifierMailer < ApplicationMailer
  default :from => 'test@wehaul.ng'
  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user)
    @user = user
    mail( :to => "imorobebh@gmail.com",
    :subject => 'Thanks for signing up for our amazing app' )
  end
end