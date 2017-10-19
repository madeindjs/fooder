class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  before_action :check_owner, only: [:edit, :update, :destroy]
  before_action :check_admin, only: [:edits]

  layout 'admin', only: [:edit, :new]


  # GET /links/new
  def new
    render '_form', locals: {link: Link.new}, layout:  false
  end

  # GET /links/1/edit
  def edit
    render '_form', locals: {link: @link}, layout:  false
  end

  # POST /links
  def create
    @link = Link.new link_params
    @link.restaurant_id = @restaurant.id

    if @link.save
      render 'links/_list', locals: {links: @restaurant.links}, layout: false
    else
      render '_form', locals: {link: @link}, layout:  false, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /links/1
  def update
    if @link.update(link_params)
      render 'links/_list', locals: {links: @restaurant.links}, layout: false
    else
      render '_form', locals: {link: @link}, layout:  false, status: :unprocessable_entity
    end
  end

  # DELETE /links/1
  def destroy
    @link.destroy
    render 'links/_list', locals: {links: @restaurant.links}, layout: false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:name, :url)
    end

    def check_owner
      redirect_to root_path unless current_user.restaurants.include? @restaurant
    end
end
