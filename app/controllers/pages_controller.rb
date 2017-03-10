class PagesController < ApplicationController

  def home
    @title = "Home"
    render layout: 'layout_landing'
  end

  def cost
  end

end
