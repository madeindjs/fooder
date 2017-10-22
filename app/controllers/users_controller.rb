class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_owner, only: [:edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @title = "Nos utilisateurs"
    @description = "Liste de nos plus fervents utilisateurs"
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @title = @user.complete_name
    @description = "Informations relatives à #{@user.complete_name}"
    @jsonld = @user.to_jsonld
  end

  # GET /users/new
  def new
    @title = "Créer un nouveau compte"
    @description = "Formulaire de création de compte sur Votre.Restaurant"

    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @title = "Editer #{@user.complete_name}"
    @description = "Editer les informations relatives à #{@user.complete_name}."

  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      # if super user create something, do not send confirmation, activate tis account & login as this user 
      if current_user and current_user.super_user?
        @user.confirm_email!
        UserSession.create(@user)
        flash[:success] = "Votre compte a été créé avec succès."
      else
        @user.maybe_deliver_email_confirmation! self
        flash[:success] = "Votre compte a été créé avec succès, un email de confirmation vous a été envoyé."
      end

      redirect_to @user
    else
      flash[:danger] = "Une erreur est survenue."
      render :new
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update_attributes user_params
      # check if we need to re-sent an confirmation email
      if @user.maybe_deliver_email_confirmation! self
        flash[:success] = "Votre compte a été mise à jour, un email de confirmation vous a été envoyé."
      else
        flash[:success] = "Votre compte a été mise à jour."
      end
      redirect_to @user
    else
      flash[:danger] = "Une erreur est survenue."
      render 'edit'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    flash[:success] = "Votre post a été mise à jour."
    redirect_to users_url
  end


  def confirm_email
    if user = User.find_using_email_token(params[:token], 5.days)
      if user.activated
        flash[:danger] = 'Votre email a déjà été confirmée.'
      else
        user.confirm_email!
        UserSession.create(user)
        flash[:success] = 'Votre email est maintenant confirmé!'
      end
    else
      flash[:danger] = 'Une erreur est survenue.'
    end
    redirect_to root_url
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:username, :firstname, :lastname, :email, :password, :password_confirmation)
  end

  def check_owner
    redirect_to root_path unless current_user == @user
  end
end
