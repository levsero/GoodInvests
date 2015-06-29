class UserMailer < ApplicationMailer
  default from: 'password_reset@goodinvests.co'

  def welcome_email(user)
    @user = user
    @url  = 'http://goodinvests.co'
    mail(to: user.email, subject: 'Welcome to GoodInvests')
  end

  def password_reset(user)
    @user = user
    @url = api_password_reset_url_url(token: user.session_token, email: user.email)
    mail(to: user.email, subject: 'Reset password')
  end
end
