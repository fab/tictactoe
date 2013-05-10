get 'game/:id' do
  Game.find(params[:id])
  
end