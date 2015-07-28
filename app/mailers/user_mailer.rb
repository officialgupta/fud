class UserMailer < ApplicationMailer
  def digest(user)
    @user = user
    mail(to: @user.email, subject: "Here's your weekly Füd Digest!")
  end
end
