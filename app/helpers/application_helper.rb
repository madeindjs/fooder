module ApplicationHelper

  def glyphicon name
    "<span class=\"glyphicon glyphicon-#{name}\" aria-hidden=\"true\"></span>".html_safe
  end


  def alert type, content
    "<div class=\"col-xs-12 alert alert-#{type}\" role=\"alert\">#{content}</div>".html_safe
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
  def picture_tag model, cutsom_field, css_class: "", size: nil
    # build options
    option_selected = ImageFormat::DISPLAY[ @restaurant.send cutsom_field ]
    options = {
      alt: "photo du #{model}",
      class: "img-responsive #{option_selected.values.first} #{css_class}"
    }
    options['size'] = size if size

    if model.picture.thumb.file.nil?
      # todo: replace this url
      url = "https://recipes.heart.org/-/media/aha/recipe/course-category-icons/side-dishes.svg"
    else
      url = model.picture.thumb.url
    end
    image_tag url, options
  end


  def tooltip content
    if admin?
      html = 'title="' + h(content) + '"'
      html.html_safe
    end
  end


end
