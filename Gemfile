source 'https://ruby.taobao.org'

gem 'rails', '3.2.18'
gem 'rake', '>= 10.1.1'
gem 'jquery-rails', '~> 2.0.2'
gem 'coderay', '~> 1.1.0'
gem 'fastercsv', '~> 1.5.0', platforms: [:mri_18, :mingw_18, :jruby]
gem 'builder', '3.0.0'
gem 'mime-types'
gem 'awesome_nested_set', '2.1.6'

gem 'dalli','>= 2.7.2'

# Optional gem for LDAP authentication
group :ldap do
  gem 'net-ldap', '~> 0.6.1'
end


platforms :mri, :mingw do
  group :rmagick do
    gem 'rmagick', '>= 2.13.2'
  end

  # Optional Markdown support, not for JRuby
  group :markdown do
    gem 'redcarpet', '>= 3.1.2'
  end
end


# Include database gems for the adapters found in the database
# configuration file
require 'erb'
require 'yaml'
gem 'mysql2'

group :development do
  gem 'rdoc', '>= 2.4.2'
  gem 'yard'
  gem 'thin'
end

group :production do
  gem 'puma','>= 2.8.2'
end

group :test do
  gem 'shoulda', '~> 3.3.2'
  gem 'mocha', '>= 0.14', :require => 'mocha/api'
  if RUBY_VERSION >= '1.9.3'
    gem 'capybara', '~> 2.1.0'
    gem 'selenium-webdriver'
  end
end

local_gemfile = File.join(File.dirname(__FILE__), 'Gemfile.local')
if File.exists?(local_gemfile)
  puts 'Loading Gemfile.local ...' if $DEBUG # `ruby -d` or `bundle -v`
  instance_eval File.read(local_gemfile)
end

# Load plugins' Gemfiles
Dir.glob File.expand_path('../plugins/*/Gemfile', __FILE__) do |file|
  puts "Loading #{file} ..." if $DEBUG # `ruby -d` or `bundle -v`
  eval_gemfile file
end
