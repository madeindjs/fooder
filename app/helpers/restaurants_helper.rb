module RestaurantsHelper

  # Create an image tag with option
  def logo_tag restaurant
    unless restaurant.logo.thumb.file.nil?
      option_selected = Restaurant::DISPLAY[ restaurant.logo_display ]

      image_tag restaurant.logo.thumb.url , class: option_selected.values.first
    end
  end

end
