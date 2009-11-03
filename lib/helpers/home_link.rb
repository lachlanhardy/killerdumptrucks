module Killerdumptrucks
  module Helpers
    def home_link(text)
      (@category == "about" ? '<span>' + text + '</span>' : '<a href="/about/">' + text + '</a>')
    end
  end
end