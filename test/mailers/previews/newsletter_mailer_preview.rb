# Preview all emails at http://localhost:3000/rails/mailers/newsletter_mailer
class NewsletterMailerPreview < ActionMailer::Preview

  def discover
    NewsletterMailer.discover "customer@restaurant.fr"
  end

end
