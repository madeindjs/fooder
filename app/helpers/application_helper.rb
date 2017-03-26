module ApplicationHelper

  def glyphicon name
      "<span class=\"glyphicon glyphicon-#{name}\" aria-hidden=\"true\"></span>".html_safe
  end


  def alert type, content
    "<div class=\"alert alert-#{type}\" role=\"alert\">#{content}</div>".html_safe
  end


  def bootstrap_label color, content
    "<span class=\"label label-#{color}\">#{content}</span>".html_safe
  end 


  def tags tags
    return nil unless tags
    html = ""
    tags.split(';').each { |tag| html += "<span class=\"label label-info\">#{tag}</span>" }
    html.html_safe
  end

  def price number
    number_to_currency number, unit: "€", format: "%n %u"
  end

  def admin?
    @restaurant && current_user && @restaurant.user_id == current_user.id
  end

  def display_options selected = nil
    options_array = ImageFormat::DISPLAY.map{ |id, data|
      [data.keys.first, id]
    }

    return options_for_select(options_array, selected: selected)
  end

  # Create a picture tag with option
  def picture_tag model, cutsom_field, css_class: "", size: 50
    unless model.picture.thumb.file.nil?
      option_selected = ImageFormat::DISPLAY[ @restaurant.send cutsom_field ]

      image_tag model.picture.thumb.url, 
          class: "#{option_selected.values.first} #{css_class}", 
          alt: "photo du #{model}", 
          size: size
    end
  end


end
