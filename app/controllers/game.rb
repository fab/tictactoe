get '/game/:id' do
  erb :game
end

post '/game/:id' do
  content_type :json
  game = Game.find(params[:id])
  {GameID: game.id, Moves: game.moves, 
  Player1: game.users[0].username, Player2: game.users[1].username, Winner: game.winnner_id}.to_json
end