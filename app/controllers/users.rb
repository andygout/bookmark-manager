
get '/users/new' do
  @user = User.new
  erb :'users/new'
end

post '/users' do
  @user = User.create( email: params[:email],
                      password: params[:password],
                      password_confirmation: params[:password_confirmation])
  if @user.save
    session[:user_id] = @user.id
    redirect to('/')
  else
    flash.now[:errors] = @user.errors.full_messages
    erb :'users/new'
  end
end

post '/users/password_reset' do
  email = params[:forgot]
  user = User.first(email: email)
  user.password_token = (1..50).map{('A'..'Z').to_a.sample}.join
  user.password_token_timestamp = Time.now
  user.save
  user.email_token
  flash[:notice] = 'Token submitted'
  redirect to('/')
end

post '/users/password_reset/:token' do

end