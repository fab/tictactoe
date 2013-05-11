get '/game/:id' do
  # game = Game.find(params[:id])
  # game.update_attributes(moves: [])
  @gameid = params[:id]
  erb :game
end

get '/creategame' do
  game = Game.create(moves: '')
  redirect "/game/#{game.id}"
end

post '/game/:id' do
  puts params
  content_type :json
  game = Game.find(params[:id])
  puts game
  new_moves = game.moves + params[:box]
  game.update_attributes(moves: new_moves)
  moves_array = new_moves.split('')
  # {GameID: game.id, Moves: game.moves, 
  # Player1: game.users[0].username, Player2: game.users[1].username, Winner: game.winnner_id}.to_json
  {GameID: game.id, Moves: moves_array}.to_json
end

post '/checkmoves/:id' do
  content_type :json
  game = Game.find(params[:id])
  moves_array = game.moves.split('')
  # {GameID: game.id, Moves: game.moves, 
  # Player1: game.users[0].username, Player2: game.users[1].username, Winner: game.winnner_id}.to_json
  {GameID: game.id, Moves: moves_array}.to_json
end