class PasswordResetsController < ApplicationController
   # Method from: http://github.com/binarylogic/authlogic_example/blob/master/app/controllers/application_controller.rb
  before_action :load_user_using_perishable_token, :only => [ :edit, :update ]
 
  def new
    @title = "Mot de passe oublié"
    @description = "Entrez votre email pour changer votre mot de passe."
  end
 
  def create
    email_sent = params[:email]
    if @user = User.find_by_email(email_sent)
      if @user.activated
        @user.deliver_password_reset_instructions!
        flash[:success] = "Un email vous à été envoyé avec les instructions pour changer votre mot de passe."
        redirect_to root_path
      else
        flash[:danger] = "Ce compte n'est pas encore actif."
        redirect_to new_password_reset_path
      end
    else
      flash[:danger] = "Aucun utilisateur avec le mail \"#{email_sent}\" n'a été trouvé"
      redirect_to new_password_reset_path
    end
  end
 
  def edit
    @title = "Mettre à jour le mot de passe"
    @description = "Créer une nouvelle catégories pour vos plats."
  end
 
  def update
    if @user.update_attributes password_params
      flash[:success] = "Votre mot de passe a été mis à jour"
      redirect_to @user
    else
      flash[:danger] = @user.errors.full_messages
      render :edit
    end
  end
 
 
  private
 
  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id])
    unless @user
      flash[:danger] = "Nous n'avons pas retrouvé votre compte."
      redirect_to root_url
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def password_params
    params.permit(:password, :password_confirmation)
  end
end
