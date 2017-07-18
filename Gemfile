source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.0.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'devise'
gem 'cancancan'
gem 'materialize-sass'
gem 'material_icons'
gem 'redis'

group :test do
  gem "factory_girl_rails"
  gem "ffaker"
end

group :development, :test do
  gem 'rspec-rails', '~> 3.5'
  gem 'byebug', platform: :mri
  gem 'listen'
  gem 'capybara'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
