class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user_session, :current_user

  before_action :found_restaurant


  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def found_restaurant
    begin
      
      if request.subdomain
        @restaurant = Restaurant.friendly.find request.subdomain
      elsif params[:restaurant_id]
        @restaurant = Restaurant.friendly.find params[:restaurant_id]
      end
    rescue ActiveRecord::RecordNotFound => e
      redirect_to home_path  
    end
  end

  def check_login
    unless current_user_session
      redirect_to params[:restaurant_id] ? restaurant_path(params[:restaurant_id]) : home_path  
    end
  end

  helper_method :current_user_session, :current_user

end
