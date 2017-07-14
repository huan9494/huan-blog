# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
Date::DATE_FORMATS[:default] = "%Y-%m-%d"
Time::DATE_FORMATS[:default] = "%Y-%m-%d %H:%M"