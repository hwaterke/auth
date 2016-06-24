get '/auth' do
  if logged_in?
    halt 200
  else
    halt 401
  end
end

post '/login' do
  login
  if logged_in?
    flash[:success] = warden.message
  else
    flash[:error] = warden.message
  end
  redirect to '/'
end

get '/logout' do
  logout!
  redirect to('/')
end

get '/' do
  slim :index, layout: :layout
end
