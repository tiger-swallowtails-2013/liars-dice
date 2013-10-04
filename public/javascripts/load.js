function roll_dice(number_of_dice_to_roll) {
  var rolls = []
  for (var i = 0; i < number_of_dice_to_roll; i++) {
    rolls[i] = Math.floor( Math.random() * 6 ) + 1;
  }
  return rolls
}

function print_dice(rolls_array){
  var diename;
  _.each(rolls_array, function(roll, i){
    diename = "#die" + (i + 1)
    $( diename ).attr("src", "die" + roll + "_render.png")
  })
}

// always refresh score
function refresh_game_board(){
  if ($('.play').length > 0){
    setInterval(function(){ 
      $.ajax({
        type: 'get',
        url: '/refresh_game_board'
      }).done(function(server_data) {
        console.log("SUCCESS: refresh_game_board");
        $('.player_queue').html(server_data)
      }).fail(function(){
        console.log('fail refresh_game_board');
      });
    }, 3000)
  }
}
  // conditional refresh
  function refresh_current_player(){
    if ($('.play').length > 0){
      setInterval(function(){ 
        $.ajax({
          type: 'get',
          url: '/refresh_current_player',
          statusCode: {
            200: function() {
              console.log("SUCCESS: refresh_current_player");
              $( "#roll-btn" ).show()
              $( '#bullshit').show()
            },
            400:function(){
              console.log('FAIL refresh_current_player');
              $( "#roll-btn" ).hide()
              $( '#bullshit').hide()
            }
          }
        })
      }, 4000)
    }
  }


$( document ).ready(function() {
  $( "#roll-btn" ).hide()
  $( '#bullshit').hide()
  $( '#your_dice').hide();
  refresh_game_board()
  refresh_current_player()

  $( "#roll-btn" ).on( "click", function() {
    var number_of_dice = $(this).data('dice-count')
    var rolls = roll_dice(number_of_dice);
    print_dice(rolls);
    $(".claim_form").toggle();
    console.log(rolls)
    $.post('/rolls', { data: rolls } )
  });

  $( "#claim-btn" ).on( "click", function() {
    $('.claim_form').toggle();
    $( "#roll-btn" ).hide();
    $( '#bullshit').hide();
    $( '#your_dice').hide();
    
  });


});