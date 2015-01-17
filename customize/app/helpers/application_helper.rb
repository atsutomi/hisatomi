module ApplicationHelper
  def dish_image_tag(dish, options = {})
    if dish.image.present?
      path = dish_path(dish, format: dish.image.extension)
      link_to(image_tag(path, { alt: dish.name }.merge(options)), path)
    else
      ""
    end
  end

  def dish_image_tag_list(dish, options = {})
    if dish.image.present?
      path = dish_path(dish, format: dish.image.extension)
      if controller.kind_of?(Admin::Base)
        link_to(image_tag(path, { alt: dish.name }.merge(options)), [:admin, dish])
      else
        link_to(image_tag(path, { alt: dish.name }.merge(options)), dish)
      end
    else
      ""
    end
  end
end
