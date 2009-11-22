module Killerdumptrucks
  module Helpers
    def link_or_span_if_current_path(text, href)
      capture_haml do
        if request.path == href
          haml_tag(:span, text)
        else
          haml_tag(:a, text, :href => href)
        end
      end
    end
  end
end