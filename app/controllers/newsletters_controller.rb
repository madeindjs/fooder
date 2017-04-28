class NewslettersController < ApplicationController
  before_action :set_newsletter, only: [:destroy]


  # POST /newsletters
  # POST /newsletters.json
  def create
    if Newsletter.new(newsletter_params).save
      flash['success'] = 'Votre email a été ajouté à la newsletter.'
    else
      flash['danger'] = 'Une erreur est survenue.'
    end

    redirect_to root_path
  end

  # DELETE /newsletters/1
  # DELETE /newsletters/1.json
  def destroy
    @newsletter.destroy
    flash['success'] = 'Votre email a été supprimé de la newsletter.'
    redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_newsletter
      @newsletter = Newsletter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def newsletter_params
      params.require(:newsletter).permit(:email)
    end
end
