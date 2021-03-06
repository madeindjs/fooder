module RestaurantsHelper

  # Create an image tag with option
  def logo_tag restaurant
    unless restaurant.logo.thumb.file.nil?
      option_selected = ImageFormat::DISPLAY[ restaurant.picture_display ]

      image_tag restaurant.logo.thumb.url , class: option_selected.values.first
    end
  end

  # Create a unique link to generate a key to accross session between domain
  def restaurant_with_session_key_url restaurant
    signin_url subdomain: restaurant, user_session: {
      key: restaurant.user.public_login_key,
      id: restaurant.user.id
    } 
  end

end
