# template from https://www.sitepoint.com/rails-authentication-with-authlogic/
class UserSessionsController < ApplicationController
  def new
    @title = "Se connecter"
    @description = "Connexion à l'interface d'administration."

    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(user_session_params)
    if @user_session.save
      flash[:success] = "Bonjour #{@user_session.user.firstname}!"
      redirect_to @user_session.user
    else
      flash[:success] = "Une erreur est survenue lors de la création de votre compte."
      render :new
    end
  end

  def destroy
    current_user_session.destroy
    flash[:success] = "A bientôt!"
    redirect_to root_path
  end

  private

  def user_session_params
    params.require(:user_session).permit(:email, :password, :remember_me)
  end
end