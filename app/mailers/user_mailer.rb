class UserMailer < ApplicationMailer

  def email_confirmation user, controller
    @user = user
    @url  = confirm_email_url(token: user.email_token)
    mail(to: @user.email, subject: 'Bienvenue sur Fooder, confirmez votre email dès à présent')
  end

  def contact data
    @content = data['content']
    @email   = data['email']
    @object  = data['content']
    mail(to: 'support@votre.restaurant', subject: @object)
  end

  def password_reset user
    @url = edit_password_reset_url(user.perishable_token)
    mail(subject: "Changement de votre mot de passe", to: user.email)
  end

end
