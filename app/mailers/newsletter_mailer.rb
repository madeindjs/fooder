class NewsletterMailer < ApplicationMailer

  def discover email
    mail(to: email, subject: "Découvrez Fooder")
  end

end
