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
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.restaurant_id = @restaurant.id

    respond_to do |format|
      if @post.save
        flash[:success] = "Votre post a été cré."
        format.html { redirect_to @post }
        format.json { render :show, status: :created, location: @post }
      else
        flash[:danger] = "Une erreur est survenue."
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        flash[:success] = "Votre post a été mise à jour."
        format.html { redirect_to @post}
        format.json { render :show, status: :ok, location: @post }
      else
        flash[:danger] = "Une erreur est survenue."
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    flash[:success] = "Votre post a été supprimé."
    respond_to do |format|
      format.html { redirect_to posts_path}
      format.json { head :no_content }
    end
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
