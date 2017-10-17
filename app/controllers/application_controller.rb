class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  helper_method :current_user_session, :current_user

  before_action :found_restaurant

  layout 'application'

  protected

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
    rescue ActiveRecord::RecordNotFound
    end
  end

  def check_restaurant
    # TODO: repair this
    redirect_to root_url(subdomain: '') unless @restaurant
  end

  def check_login
    render_alert unless current_user
  end

  def check_admin
    render_alert unless current_user and current_user.restaurants.include? @restaurant
  end

  def check_super_user
    render_alert unless current_user and current_user.email == User::SUPER_USER
  end


  def render_alert
    render plain: '<div class="alert alert-danger">Vous n\'avez pas le droit d\'accéder à cette page</div>', status: 403
  end

  helper_method :current_user_session, :current_user

end
