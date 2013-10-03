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
    $( diename ).text(roll)
  })
}

function play_page_refresh(){
  if ($('.play').length > 0){
    setInterval(function(){ 
      $.ajax({
        type: 'post',
        url: '/refresh_check'
        //data:
      }).done(function(server_data) {
        console.log("SUCCESS:" + server_data);
        $(".players").html(server_data["waiting"]);
        if (server_data["current"]){
          $(".test").html(server_data["current"]);
        }
      }).fail(function(){
        console.log('fail');
      });

    }, 5000)
  }
}

$( document ).ready(function() {
  play_page_refresh()

  $( "#roll-btn" ).on( "click", function() {
    var number_of_dice = $(this).data('dice-count')
    var rolls = roll_dice(number_of_dice);
    print_dice(rolls);
    $("#bid-btn").removeAttr("disabled");
    $("#roll-btn").attr("disabled", true)
    console.log(rolls)
    $.post('/rolls', { data: rolls } )
  });
});