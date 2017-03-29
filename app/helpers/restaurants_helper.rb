module RestaurantsHelper

  # Create an image tag with option
  def logo_tag restaurant
    unless restaurant.logo.thumb.file.nil?
      option_selected = ImageFormat::DISPLAY[ restaurant.logo_display ]

      image_tag restaurant.logo.thumb.url , class: option_selected.values.first
    end
  end

  # create a link for administrator with a new session
  def link_to_restaurant_with_session_key restaurant
    link_to 'Voir le site', 
      user_sessions_url(subdomain: restaurant, user_session: {key: 2812, id: current_user.id }), 
      class: 'btn btn-primary', method: :post
  end

end
