source 'https://rubygems.org'
puppetversion = ENV.key?('PUPPET_VERSION') ? "= #{ENV['PUPPET_VERSION']}" : ['>= 2.7']

gem 'puppet', puppetversion

group :development, :test do
  gem 'puppet-blacksmith'
  gem 'puppet-lint'
  gem 'puppetlabs_spec_helper'
  gem 'rake', '>=0.9.2.2'
  gem 'rspec', '< 3.0.0'
  gem 'rspec-puppet'
  gem 'guard'
  gem 'guard-rake'
  gem 'guard-rspec'
  gem 'rb-inotify', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-fchange', :require => false
  gem 'growl',      :require => false
  gem 'libnotify',  :require => false
end
