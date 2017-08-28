class MailingsController < ApplicationController
  before_action :check_super_user
  before_action :set_mailing, only: [:show, :edit, :update, :destroy]

  # GET /mailings
  # GET /mailings.json
  def index
    @mailings = Mailing.all
  end

  # GET /mailings/1
  # GET /mailings/1.json
  def show
  end

  # GET /mailings/new
  def new
    @mailing = Mailing.new
  end

  # GET /mailings/1/edit
  def edit
  end

  # POST /mailings
  # POST /mailings.json
  def create
    @mailing = Mailing.new(mailing_params)

    respond_to do |format|
      if @mailing.save
        format.html { redirect_to @mailing, notice: 'Mailing was successfully created.' }
        format.json { render :show, status: :created, location: @mailing }
      else
        format.html { render :new }
        format.json { render json: @mailing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mailings/1
  # PATCH/PUT /mailings/1.json
  def update
    respond_to do |format|
      if @mailing.update(mailing_params)
        format.html { redirect_to @mailing, notice: 'Mailing was successfully updated.' }
        format.json { render :show, status: :ok, location: @mailing }
      else
        format.html { render :edit }
        format.json { render json: @mailing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mailings/1
  # DELETE /mailings/1.json
  def destroy
    @mailing.destroy
    respond_to do |format|
      format.html { redirect_to mailings_url, notice: 'Mailing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_mailing
    @mailing = Mailing.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def mailing_params
    params.require(:mailing).permit(:restaurant_id, :mail)
  end
end
