get '/sessions/new' do
  erb :'sessions/new'
end

post '/sessions' do
  email, password = params[:email], params[:password]
  user = User.authenticate(email, password)
  if user
    session[:user_id] = user.id
    redirect to('/')
  else
    flash[:errors] = ['The email or password is incorrect']
    erb :'sessions/new'
  end
end

delete '/sessions' do
  flash[:notice] = 'Good bye!'
  session[:user_id] = nil
  redirect to('/')
end

post '/password/reset' do
  email = params[:forgot]
  user = User.first(email: email)
  user.password_token = (1..50).map{('A'..'Z').to_a.sample}.join
  user.password_token_timestamp = Time.now
  user.save
    flash[:notice] = 'Token submitted'
  redirect to('sessions/new')
end