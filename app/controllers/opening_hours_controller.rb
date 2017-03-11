class OpeningHoursController < ApplicationController
  before_action :set_opening_hour, only: [:update, :destroy]
  before_action :check_login, only: [:create, :update, :destroy]
  before_action :check_owner, only: [:edit, :update, :destroy]


  # POST /restaurant/1/opening_hours/1
  def create
    @opening_hour = OpeningHour.new(opening_hour_params)
    @opening_hour.user_id = current_user.id
    @opening_hour.restaurant_id = @restaurant.id

    if @opening_hour.save
      redirect_to root_path, notice: "Horraire d'ouverture crée."
    else
      puts @opening_hour.errors.inspect
      redirect_to root_path, notice: "Une erreur est survenue."
    end
  end

  # PATCH/PUT /restaurant/1/opening_hours/1
  def update
    if @opening_hour.update(opening_hour_params)
      redirect_to root_path, notice: "Horraire d'ouverture mise à jour."
    else
      puts @opening_hour.errors.inspect
      redirect_to root_path, notice: "Une erreur est survenue."
    end
  end

  # DELETE /opening_hours/1
  # DELETE /opening_hours/1.json
  def destroy
    @opening_hour.destroy
    redirect_to root_path, notice: "Horraire d'ouverture supprimée."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opening_hour
      @opening_hour = OpeningHour.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def opening_hour_params
      params.require(:opening_hour).permit(:day, :closes, :opens, :valid_from, :valid_through)
    end

    def check_owner
      redirect_to root_path unless current_user.opening_hours.include? @opening_hour
    end
end
