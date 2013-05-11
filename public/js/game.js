var playerTurn = 0;
var winningCombos = '';
var board = [];
var content = [];

function initalBoardRender(){
  for(var i = 0; i <= 8; i++) {
    board[i] = false;
    content[i] = "";
  }
}

function turnBoardRender(game){
  moves = game.Moves;
  $.each(moves, function(index, space){
    if (index % 2 === 0) {
      board[space] = true;
      content[space] = "X";
    } else {
      board[space] = true;
      content[space] = "O";
    }
  });
  redrawTable(content);
}

function redrawTable(content){
  $.each(content, function(index, xOrO){
    $('#' + index).text(xOrO);
  });
}

function ajax(choice) {
  $.ajax({
    url: '/game/' + gameID, //get game id
    method: 'post',
    data: { box : choice }
  }).done(function(response){
    turnBoardRender(response);
  });
}

function checkMoves() {
  $.ajax({
    url: '/checkmoves/' + gameID, //get game id
    method: 'post'
  }).done(function(response){
    turnBoardRender(response);
  });
}


$(document).ready(function() {
  // console.log(myclass.getUniqueWindowId( thisSession ));
  initalBoardRender();
  setInterval(checkMoves, 10);
  gameID = $('#board').data('gameid');
  console.log(gameID);
  $('#board').on('click', 'td', function() {
    console.log('clicked');
    var id = $(this).attr('id');
    console.log(id);
    turn(id);
  });

  function turn(choice) {
    console.log(board);
    console.log(choice);
    console.log(typeof choice);
    choiceNum = parseInt(choice);
    console.log(typeof choiceNum);
    if(board[choice] === false) {
      if(playerTurn % 2 === 0) {
        content[choice] = "X";
        board[choice] = true;
        ajax(choice);
      } else {
        content[choice] = "O";
        board[choice] = true;
        ajax(choice);
      }
      playerTurn++;
    } else {
      alert("That space is filled, homes!");
    }
  }
});

  // take moves array from ruby
  // make a moves array in JS
  // after a successful choice push choice to moves array
  // send moves array to ruby database