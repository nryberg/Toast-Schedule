Time::DATE_FORMATS[:month_and_year] = "%B %Y"
Time::DATE_FORMATS[:pretty] = lambda { |time| time.strftime("%a, %b %e at %l:%M") + time.strftime("%p").downcase }
Time::DATE_FORMATS[:month_day_year] = "%B\/%D\/%Y"
Date::DATE_FORMATS[:default] = "%m/%d/%Y"
