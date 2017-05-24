class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :check_login, only: [:new, :create, :edit, :update, :destroy]
  before_action :check_owner, only: [:edit, :update, :destroy]

  layout 'admin', only: [:edit, :new]

  # GET /posts
  # GET /posts.json
  def index
    @title = "Actualité"
    @description = "Actualité autour du restaurant #{@restaurant.name}."

    @posts = @restaurant.posts
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @title = @post.title
    @description = "'#{@post.title}' à propos de #{@restaurant.name}"
  end

  # GET /posts/new
  def new
    @title = "Nouvel article"
    @description = "Ecrire un nouvel article sur le restaurant #{@restaurant.name}."

    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @title = "Editer #{@post.title}"
    @description = "Editer l'article appelé #{@post.title}"
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.restaurant_id = @restaurant.id

    if @post.save
      flash[:success] = "Votre post a été cré."
      redirect_to @post
    else
      flash[:danger] = "Une erreur est survenue."
      render :new
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      flash[:success] = "Votre post a été mise à jour."
      redirect_to @post
    else
      flash[:danger] = "Une erreur est survenue."
      render :edit
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    flash[:success] = "Votre post a été supprimé."
    redirect_back fallback_location: posts_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :tags, :picture)
    end

    def check_owner
      redirect_to root_path unless current_user.posts.include? @post
    end
end
