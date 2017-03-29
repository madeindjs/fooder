module RestaurantsHelper

  # Create an image tag with option
  def logo_tag restaurant
    unless restaurant.logo.thumb.file.nil?
      option_selected = ImageFormat::DISPLAY[ restaurant.logo_display ]

      image_tag restaurant.logo.thumb.url , class: option_selected.values.first
    end
  end

  # Create a unique link to generate a key to accross session between domain
  def link_to_restaurant_with_session_key restaurant
    link_to 'Voir le site', 
      user_sessions_url(subdomain: restaurant, user_session: {key: current_user.public_login_key, id: current_user.id }), 
      class: 'btn btn-primary', method: :post
  end

end
