source 'https://rubygems.org'

group :development, :test do
  gem 'coveralls',               :require => false
  gem 'mime-types', '<2.0',      :require => false
  gem 'rake',                    :require => false
  gem 'rspec-puppet',            :require => false
  gem 'puppetlabs_spec_helper',  :require => false
  gem 'rspec-system',            :require => false
  gem 'rspec-system-puppet',     :require => false
  gem 'rspec-system-serverspec', :require => false
  gem 'serverspec',              :require => false
  gem 'puppet-lint',             :require => false
  gem 'simplecov',               :require => false
  gem 'beaker',                  :require => false
  gem 'guard'
  gem 'guard-rspec'
  gem 'ruby_gntp' 
  gem 'guard-rspec'
  gem 'debugger'
  gem 'pry'

end

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end
