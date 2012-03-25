module ApplicationHelper

  def page_header(text)
    content_tag(:header, class: "content-header") do
      content_tag(:h1, text)
    end
  end

  def enable_challengepost_authentication?
    Capitan::Application.config.enable_challengepost_authentication
  end
end
