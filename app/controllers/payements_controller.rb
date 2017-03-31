class PayementsController < ApplicationController
  before_action :check_login
  before_action :set_payement, only: [:show, :edit, :update, :destroy]

  # GET /payements
  # GET /payements.json
  def index
    @payements = Payement.all
  end

  # GET /payements/1
  # GET /payements/1.json
  def show
  end

  # GET /payements/new
  def new
    @payement = Payement.new
  end

  # GET /payements/1/edit
  def edit
  end

  # POST /payements
  # POST /payements.json
  def create
    @payement = Payement.new(payement_params)
    @payement.user_id = current_user.id

    puts '*'*80
    puts payement_params.inspect
    puts '*'*80

    if @payement.save
      redirect_to @payement.paypal_url(payements_url)
    else
      render :new 
    end
  end

  # PATCH/PUT /payements/1
  # PATCH/PUT /payements/1.json
  def update
    if @payement.update(payement_params)
      redirect_to @payement, notice: 'Payement was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /payements/1
  # DELETE /payements/1.json
  def destroy
    @payement.destroy
    redirect_to payements_url, notice: 'Payement was successfully destroyed.'
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
