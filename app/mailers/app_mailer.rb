class AppMailer < ActionMailer::Base
  def send_welcome_email(user)
    @user = user
    mail to: user.email, from: "wengny@gmail.com", subject: "Welcome to Myflix!"
  end

  def send_forgot_password(user)
    @user = user
    mail to:user.email, from: "wengny@gmail.com", subject: "Please reset your password"
  end
end