post '/signup' do
  @user = User.create(params)
  session[:user_id] = @user.id
  erb :index
end

post '/login' do
  @user = User.authenticate(params["user_name"], params["password"])
    
  if @user
    session[:user_id] = @user.id
    @games = Game.find_all_by_moves(nil)
    erb :index
  else
    return "sorry, you fucked up"
  end
end

get '/logout' do
  session.clear
  p @user
  redirect '/'
end

get '/game/create' do
  user = User.find(session[:user_id])
  game = Game.create
  user.games << game

  @games = Game.find_all_by_moves(nil)
  p user
  erb :index
end


# get '/users/new' do
#   # render sign-up page
#   @user = User.new
#   erb :sign_ups
# end

# post '/users' do
#   # sign-up
#   @user = User.new params[:user]
#   if @user.save
#     # successfully created new account; set up the session and redirect
#     session[:user_id] = @user.id
#     redirect '/'
#   else
#     # an error occurred, re-render the sign-up form, displaying errors
#     erb :sign_up
#   end
# end