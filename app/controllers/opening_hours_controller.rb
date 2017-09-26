class OpeningHoursController < ApplicationController
  before_action :set_opening_hour, only: [:update, :destroy]
  before_action :check_login, only: [:create, :edit, :destroy]
  before_action :check_owner, only: [:edit, :destroy]

  # GET /menus/1/edit
  def edit
    begin
      @opening_hour = OpeningHour.find(params[:id])  
    rescue ActiveRecord::RecordNotFound
      @opening_hour = OpeningHour.create(restaurant_id: params[:id])
    end

    render  '_form', locals: {opening_hour: @opening_hour}, layout:  false if request.xhr?
  end


  # POST /restaurant/1/opening_hours/1
  def create
    @opening_hour = OpeningHour.new(opening_hour_params)
    @opening_hour.user_id = current_user.id
    @opening_hour.restaurant_id = @restaurant.id

    if @opening_hour.save
      flash[:success] = "Votre horraire d'ouverture a été créée."
      redirect_back fallback_location: admin_opening_hours_path
    else
      puts
      flash[:danger] = "Une erreur est survenue."
    end
  end

  # PATCH/PUT /restaurant/1/opening_hours/1
  def update
    if @opening_hour.update(opening_hour_params)
      flash[:success] = "Votre horraire d'ouverture a été mise à jour."
      redirect_back fallback_location: admin_opening_hours_path
    else
      flash[:danger] = "Une erreur est survenue."
      redirect_to root_path
    end
  end

  # DELETE /opening_hours/1
  # DELETE /opening_hours/1.json
  def destroy
    @opening_hour.destroy
    flash[:success] = "Votre horraire d'ouverture a été supprimée."
    redirect_back fallback_location: admin_opening_hours_path
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
      redirect_to root_path unless current_user.restaurants.include? @restaurant
    end
end
