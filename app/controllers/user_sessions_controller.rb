# template from https://www.sitepoint.com/rails-authentication-with-authlogic/
class UserSessionsController < ApplicationController
  def new
    @title = "Se connecter"
    @description = "Connexion à l'interface d'administration."

    @user_session = UserSession.new
  end

  def create

    # if key is present, it's POST query from main website, so we try to identificate
    if user_session_params.has_key?(:id) and user_session_params.has_key?(:key)
      user = User.find user_session_params['id']
      @user_session = UserSession.new user if user_session_params['key'] = user.public_login_key
    else
      @user_session = UserSession.new user_session_params
    end

    # Try to create session
    if @user_session.save
      flash[:success] = "Bonjour #{@user_session.user.firstname}!"
      redirect_to @user_session.user
    else
      flash[:success] = "Une erreur est survenue lors de la création de votre compte."
      render :new
    end
  end

  def destroy
    current_user_session.destroy if current_user_session
    flash[:success] = "A bientôt!"
    redirect_to root_path
  end

  private

  def user_session_params
    params.require(:user_session).permit(:email, :password, :remember_me, :key, :id)
  end
end