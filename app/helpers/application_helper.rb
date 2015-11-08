module ApplicationHelper
  def custom_stylesheet_link_tag(stylesheet)
    unless stylesheet.empty?
      stylesheet_link_tag stylesheet, media: "all", "data-turbolinks-track" => true
    end
  end
end
