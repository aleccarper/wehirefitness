source 'http://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.4'


# Assets
gem 'autoprefixer-rails'
gem 'compass-rails'
gem 'd3-rails'
gem 'fastclick-rails'
gem 'font-awesome-sass'
gem 'handlebars_assets'
gem 'jquery-rails'
gem 'jquery-turbolinks'
gem 'jquery-ui-rails'
gem 'oily_png'
gem 'sass-globbing'
gem 'sass-rails'
gem 'slim'
gem 'sprockets-image_compressor'
gem 'uglifier'
gem 'underscore-rails'
gem 'turbolinks'

gem 'bootstrap-sass', '~> 3.3.6'
gem 'bootsy'
gem 'devise'
gem 'geocoder'

gem 'rake'
gem 'pg'
gem 'postmark-rails'
gem 'meta-tags'

gem 'stripe', :git => 'https://github.com/stripe/stripe-ruby'
gem 'activerecord-session_store', github: 'rails/activerecord-session_store'

group :development, :test do
  gem 'letter_opener'
	gem "better_errors"
	gem "byebug"
end

group :staging, :production do
  gem 'heroku'
  gem 'newrelic_rpm'
  gem 'rails_12factor'
end

group :test do
  gem 'capybara-webkit'
  gem 'connection_pool'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'pry-byebug'
  gem 'rb-fsevent'
  gem 'rspec-rails'
  gem 'selenium-webdriver', '>=2.45.0.dev3'
  gem 'stripe-ruby-mock', '~> 2.0.5', require: 'stripe_mock'
  gem 'timecop'
  gem 'rspec-stripe'
end
