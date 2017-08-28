class MailingsController < ApplicationController
  before_action :check_super_user

  # GET /mailings
  def index
    @mailings = Mailing.includes(:restaurant).all
  end


  # GET /mailings/new
  def new
    @mailing = Mailing.new
  end


  # POST /mailings
  def create
    @mailing = Mailing.new(mailing_params)

    if @mailing.save
      redirect_to @mailing, success: 'Mailing was successfully created.'
    else
      render :new
    end
  end


  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def mailing_params
    params.require(:mailing).permit(:restaurant_id, :mail)
  end
end
