source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Use PostgreSQL as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.11'

# Assets - Theme & Icons
gem 'bootstrap-sass', '~> 3.3.7'
gem 'font-awesome-rails', '~> 4.7.0.2'
gem 'coderay', '>= 1.1.1'

gem 'figaro', '>= 1.1.1'
gem 'active_model_serializers', '0.10.6'
gem 'will_paginate', '~> 3.1.5'
gem 'carrierwave', '~> 1.0.0'
gem 'mini_magick', '~> 4.6.0'
gem 'rest-client', '~> 2.0.0'

# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

group :development, :test do
  gem 'rspec', '>= 3.5.0'
  gem 'rspec-rails', '>= 3.5.0'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  gem 'factory_girl_rails', '>= 4.6.0'
  gem 'shoulda-matchers', '>= 3.1.1'
  gem 'faker'
  gem 'database_cleaner'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
