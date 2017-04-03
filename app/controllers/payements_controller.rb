# Responsible for Paypal payement
#
# @see https://launchschool.com/blog/basic-paypal-checkout-processing-in-rails/
class PayementsController < ApplicationController
  before_action :check_login, only: [:show]
  before_action :set_payement, only: [:show]

  protect_from_forgery except: [:hook] # to turn off csrf checking when Paypal send a plain HTTP POST.



  # POST /hook
  #
  # Get confirmation from paypal & redirect to payement
  # 
  # To simulate in developpement environement
  # 1. install ngrok from https://ngrok.com/download
  # 2. run it `./ngrok http 3000`
  def hook
    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
      puts '*'*80
      puts params.inspect
      puts '*'*80
      @payement = Payement.find params[:invoice]
      puts @payement.inspect
      puts '*'*80
      @payement.update_attributes notification_params: params, status: status, transaction_id: params[:txn_id], purchased_at: Time.now
    render nothing: true
  end


  # GET /payements
  # GET /payements.json
  def index
    @title = "Mes paiements"
    @description = "Consulter vos paiements effectués."

    @payements = Payement.includes(:product).where(user_id: current_user.id).all
  end

  # GET /payements/1
  # GET /payements/1.json
  def show
  end

  # GET /payements/new
  def new
    @title = "Passer premium"
    @description = "Bénéficier dès a présent d'un nom de domaine personnalisé."

    @payement = Payement.new
  end

  # POST /payements
  # POST /payements.json
  def create
    @payement = Payement.new(payement_params)
    @payement.user_id = current_user.id

    if @payement.save
      redirect_to @payement.paypal_url(payement_url(@payement))
    else
      render :new 
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payement
      @payement = Payement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payement_params
      params.require(:payement).permit :product_id
    end
end
