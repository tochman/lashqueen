source 'https://rubygems.org'


ruby '2.1.5'
gem 'rails', '4.2.1'
#gem 'airbrake'
gem 'bourbon', '~> 4.1.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'delayed_job_active_record'
gem 'email_validator'
gem 'flutie'
gem 'high_voltage'
gem 'i18n-tasks'
gem 'jquery-rails', '~> 3'
gem 'jquery-ui-rails'
gem 'jquery_mobile_rails'
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'neat', '~> 1.7.0'
gem 'newrelic_rpm'
gem 'normalize-rails', '~> 3.0.0'
gem 'pg'
gem 'rack-timeout'
gem 'recipient_interceptor'
gem 'refills'
gem 'bootstrap-sass', '~> 3.3.4'
gem 'sass-rails', '~> 5.0.1'
gem 'sprockets-rails', :require => 'sprockets/railtie'
gem 'simple_form'
gem 'title'
gem 'uglifier'
gem 'unicorn'
gem 'colorize'
gem 'responders', '~> 2.0'

#Betygsätt produkter
#gem 'ratyrate' #http://www.sitepoint.com/ratyrate-add-rating-rails-app/

group :development do
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'web-console'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :development, :test do
  gem "awesome_print"
  gem "bundler-audit", require: false
  gem "byebug"
  gem "dotenv-rails"
  gem "factory_girl_rails"
  gem "pry"
  gem "rspec-rails", "~> 3.1.0"
  gem 'regressor', git: 'https://github.com/ndea/regressor.git', branch: 'master'
end

group :test do
  gem "capybara-webkit", ">= 1.2.0"
  gem "database_cleaner"
  gem "formulaic"
  gem "launchy"
  gem "shoulda-matchers", require: false
  gem "timecop"
  gem "webmock"
end

group :staging, :production do
  gem 'rails_12factor'
end
#Adding gems for e-commerce solution
gem 'shoppe', github: 'tochman/shoppe', branch: 'customers'

#gem 'shoppe', git: 'https://github.com/tryshoppe/shoppe'
#gem 'klarna-checkout'
gem 'shoppe-stripe', git: 'https://github.com/tochman/shoppe-stripe', require: 'shoppe/stripe'
gem 'redcarpet'
gem 'faker'
