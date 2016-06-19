require 'bundler'
Bundler.require
require 'yaml'

# Load Configuration
set :server_config, YAML.load_file('config.yml')
use Rack::Session::Cookie, :key => 'auth.session', :domain => settings.server_config['cookie']['domain'], :path => '/', :secret => settings.server_config['cookie']['domain']
set :password, settings.server_config['password']

helpers do
  def logged_in?
    session[:token] == 'ok'
  end

  def login!
    session[:token] = 'ok'
  end

  def logout!
    session[:token] = nil
  end

  def http_headers
    env.select {|k,v| k.start_with? 'HTTP_'}
  end
end

get '/auth' do
  if logged_in?
    halt 200
  else
    halt 401
  end
end

post '/login' do
  login! if params['password-in'] == settings.password
  redirect to('/login')
end

get '/logout' do
  logout!
  redirect to('/login')
end

get '/login/?*' do
  slim :login, layout: :layout
end
