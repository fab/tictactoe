
get '/game/create' do
  user = User.find(session[:user_id])
  game = Game.create
  user.games << game

  @games = Game.find_all_by_moves(nil)
  p user
  erb :index
end

get '/game/:id' do
  if current_user
    Game.find(params["id"]).users << current_user
  end
  erb :game
end


post '/game/:id' do
  content_type :json
  game = Game.find(params[:id])
  {GameID: game.id, Moves: game.moves, 
  Player1: game.users[0].username, Player2: game.users[1].username, Winner: game.winnner_id}.to_json
end