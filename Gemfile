source 'http://rubygems.org'

gem 'rails', '3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

#gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'SystemTimer'
####
## Add these as defaults for new projects
###
gem 'formtastic', '~> 1.2.3'
gem 'mongo_mapper'
# gem 'jnunemaker-validatable', '>= 1.8.4'
gem 'mongomapper_ext'
gem 'haml'
gem 'haml-rails'
# Avoiding WARN  Could not determine content-length of response body error on webrick
gem 'thin'

group :production do
end
group :development, :test do
  gem 'mongrel', '>= 1.2.0.pre2'
  gem 'guard'
  gem 'guard-livereload'
  gem 'pry-rails'
  gem 'rspec', '>=2.6.0.rc4'
  gem 'rspec-rails',      "~> 2.8"
  gem 'factory_girl_rails'
  #gem 'better_errors' - this one throws binding of caller errors
  #gem 'binding_of_caller'
end

gem 'log_buddy'
# gem 'haml_scaffold'
gem 'bson_ext'
gem 'will_paginate'
gem 'mocha'
gem 'rails3-generators'
gem 'jquery-rails', '>=0.2.5'
gem 'jquery_datepicker'
gem 'awesome_print'
gem "high_voltage"
gem 'stripe'
# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:

group :test do
  gem 'faker'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'launchy'
  gem 'cucumber'
  gem 'webrat'
  gem 'cucumber-rails'
  gem 'database_cleaner'
end
