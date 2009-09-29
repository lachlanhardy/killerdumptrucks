module Killerdumptrucks
  module Helpers
    def nav_builder
      @nav_items = ["about"] #["about", "browse", "random"]
      haml(:"_navigation", :layout => false)
    end
  end
end