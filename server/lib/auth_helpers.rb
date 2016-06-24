def warden
  env['warden']
end

def user
  warden.user
end

def logged_in?
  warden.authenticated?
end

def login
  warden.authenticate
end

def logout!
  warden.logout
end
