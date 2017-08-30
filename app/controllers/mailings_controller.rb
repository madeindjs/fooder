class MailingsController < ApplicationController
  before_action :check_super_user

  # GET /mailings
  def index
    @title = "Liste des emails envoyé"
  end


  # GET /mailings/new
  def new
    @title = "Créer un email de communication"

    @mailing = Mailing.new
    @restaurants = Restaurant.where('email IS NOT NULL')
  end


  # POST /mailings
  def create
    @mailing = Mailing.new(mailing_params)
    @mailing.email = @mailing.restaurant.email
    CommercialMailer.send(@mailing.mail, @mailing.restaurant).deliver_now

    if @mailing.save
      flash['success'] = "Email was sent to #{@mailing.restaurant.email} ."
      redirect_to mailings_path
    else
      flash['danger'] = 'Mailing was not save (but email was sent).'
      render :new
    end
  end


  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def mailing_params
    params.require(:mailing).permit(:restaurant_id, :mail)
  end
end
