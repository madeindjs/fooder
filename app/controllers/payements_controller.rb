class PayementsController < ApplicationController
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

    respond_to do |format|
      if @payement.save
        format.html { redirect_to @payement, notice: 'Payement was successfully created.' }
        format.json { render :show, status: :created, location: @payement }
      else
        format.html { render :new }
        format.json { render json: @payement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payements/1
  # PATCH/PUT /payements/1.json
  def update
    respond_to do |format|
      if @payement.update(payement_params)
        format.html { redirect_to @payement, notice: 'Payement was successfully updated.' }
        format.json { render :show, status: :ok, location: @payement }
      else
        format.html { render :edit }
        format.json { render json: @payement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payements/1
  # DELETE /payements/1.json
  def destroy
    @payement.destroy
    respond_to do |format|
      format.html { redirect_to payements_url, notice: 'Payement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payement
      @payement = Payement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payement_params
      params.require(:payement).permit(:user_id, :transaction_id, :status)
    end
end
