class OpeningHoursController < ApplicationController
  before_action :set_opening_hour, only: [:update, :destroy]
  before_action :check_login, only: [:create, :edits, :destroy]
  before_action :check_owner, only: [:edits, :destroy]

  # GET  /restaurant/1/opening_hours/edits
  # POST /restaurant/1/opening_hours/edits
  def edits
    @title = "Horraires d'ouvertures."
    @description = "Gérer les horraires d'ouvertures."

    if request.post?
      # to array to save changes to display it to user
      updated_opening_hours = []
      fail_updated_opening_hours = []
      # loop on all parameters
      params.require(:opening_hour).each do |id, data|

        opening_hour_attributes = {
          restaurant_id: @restaurant.id,
          day:           data['day'],
          opens:         data['opens'],
          closes:        data['closes'],
          valid_from:    data['valid_from'],
          valid_through: data['valid_through'],
        }

        opening_hour = OpeningHour.new

        begin
          opening_hour = OpeningHour.find(id) 
        rescue ActiveRecord::RecordNotFound => e
        end

        opening_hour.attributes = opening_hour_attributes



        # save only if opening_hour changed
        if opening_hour.changed? or opening_hour.id = nil
          # save opening_hour and stor in array to display in flash message
          if opening_hour.save
            updated_opening_hours << opening_hour
          else
            puts opening_hour.errors.inspect
            fail_updated_opening_hours << opening_hour
          end
        end

      end
      # display changes
      flash[:success] = "La mise à jour des horraires d'ouverture a été effectuée." unless updated_opening_hours.empty?
      flash[:danger] = "Une erreure est survenue."  unless fail_updated_opening_hours.empty?
    end
  end


  # POST /restaurant/1/opening_hours/1
  def create
    @opening_hour = OpeningHour.new(opening_hour_params)
    @opening_hour.user_id = current_user.id
    @opening_hour.restaurant_id = @restaurant.id

    if @opening_hour.save
      flash[:success] = "Votre horraire d'ouverture a été créée."
      redirect_to opening_hours_edit_path
    else
      puts 
      flash[:danger] = "Une erreur est survenue."
    end
  end

  # PATCH/PUT /restaurant/1/opening_hours/1
  def update
    if @opening_hour.update(opening_hour_params)
      flash[:success] = "Votre horraire d'ouverture a été mise à jour."
      redirect_to opening_hours_edit_path
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
    redirect_to opening_hours_edit_path
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
