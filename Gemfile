source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# RAILS
gem 'rails', '~> 5.0.1'
gem 'mysql2'
gem 'sqlite3'
gem 'puma', '~> 3.0' # Use Puma as the app server
gem 'turbolinks', '~> 5' # Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'jbuilder', '~> 2.5' # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'friendly_id'
# PICTURE
gem 'carrierwave'
gem 'rmagick' # sudo apt-get install libmagickwand-dev
# Sitemap
gem 'sitemap_generator'
gem 'whenever', :require => false

# CSS
gem 'sass-rails', '~> 5.0'
gem 'bootstrap_form'

# JAVASCRIPT
# gem 'therubyracer', platforms: :ruby # See https://github.com/rails/execjs#readme for more supported runtimes
gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets
gem 'coffee-rails', '~> 4.2' # Use CoffeeScript for .coffee assets and views
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'momentjs-rails'

# AUTHENTIFICATION
gem 'authlogic', '>= 3.5'
gem 'authlogic_email_token'

group :development, :test do
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
  gem 'faker'

  # capistrano
  gem 'capistrano',   require: false
  gem 'capistrano-rvm',   require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler',   require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
