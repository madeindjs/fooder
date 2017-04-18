class UserMailer < ApplicationMailer
  def activate_account(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Bienvenue sur Fooder, activez votre compte dès à présent')
  end
end
