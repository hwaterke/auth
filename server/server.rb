require 'bundler'
Bundler.require
require 'yaml'

require_relative 'lib/warden'
require_relative 'lib/auth_helpers'
require_relative 'lib/models/setup'

# Load Configuration
set :server_config, YAML.load_file('config.yml')

# Configure cookies
if settings.server_config['cookie']['domain'].nil?
  use Rack::Session::Cookie, :key => 'auth.session', :secret => settings.server_config['cookie']['secret']
else
  use Rack::Session::Cookie, :key => 'auth.session', :domain => settings.server_config['cookie']['domain'], :path => '/', :secret => settings.server_config['cookie']['secret']
end
register Sinatra::Flash

# Configure Warden
use Warden::Manager do |manager|
  manager.default_strategies :password
end

# Create the single user.
set :password, settings.server_config['password']
u = User.create(email: settings.server_config['email'], password: settings.server_config['password'], password_confirmation: settings.server_config['password'])
u.save

helpers do
  def http_headers
    env.select {|k,v| k.start_with? 'HTTP_'}
  end
end

require_relative 'lib/routes.rb'
