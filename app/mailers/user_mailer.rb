class UserMailer < ApplicationMailer
  def email_confirmation user
    @user = user
    @url  = confirm_email_url user.email_token
    mail(to: @user.email, subject: 'Bienvenue sur Fooder, confirmez votre email dès à présent')
  end
end
