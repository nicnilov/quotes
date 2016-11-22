source 'https://rubygems.org'

ruby '2.3.0'                                # use rbenv or RVM to support this

gem 'rails', '~> 4.2.7'
gem 'pg', '~> 0.19'                         # NOTE: on ubuntu do `apt-get install libpq-dev`
gem 'jbuilder', '~> 2.2.0'                  # JSON serializer
gem 'pry-rails'                             # better REPL
gem 'jquery-rails'                          # Use jquery as the JavaScript library

group :assets do
  gem 'sass-rails', '~> 5.0'
  gem 'uglifier', '~> 2.7.0'
  gem 'execjs'                              # NOTE: on ubuntu install nodejs `sudo apt-get install nodejs`
end

group :development, :test do
  gem 'rspec', '~> 3.0'                     # behaviour testing
  gem 'rspec-rails', '~> 3.0'               # RSpec extenstions for Rails
  gem 'byebug'                              # debugger
  gem 'pry-byebug'                          # byebug execution control from pry
  gem 'pry-stack_explorer'                  # show and navigate stack in pry
  gem 'quiet_assets'                        # don't clutter log with served assets
  gem 'dotenv-rails'                        # load environment vars from ./.env
end

group :development do
  gem 'better_errors'                       # Better error reporting and repl web console
  gem 'spring'
end

group :production do
  gem 'rails_12factor'                        # serving statis assets and logging to stdout
end
