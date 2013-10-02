
$( document ).ready(function() {

  $( "#roll-btn" ).on( "click", function() {
    var number_of_dice = $(this).data('dice-count')
    var rolls = roll_dice(number_of_dice);
    print_dice(rolls);
  });

  function roll_dice(number_of_dice_to_roll) {
    // def roll
    //   rolls = []
    //   self.number_of_dice.times {rolls << rand(6) + 1}
    //   self.current_roll = rolls.sort.join
    //   self.save
    // end

    var rolls = []
    for (var i = 0; i < number_of_dice_to_roll; i++) {
      rolls[i] = Math.floor( Math.random() * 6 ) + 1;
    }
    console.log(rolls)

    return rolls

  }

  function print_dice(rolls_array){
    _.each(rolls_array, function(roll, i){
      console.log("hi")
      console.log(i)
      var diename = "#die" + (i + 1)
      console.log(diename)
      $( diename ).text(roll)
    })
  }

    // $( "#die1" ).text(rolls_array[0])
    // $( "#die2" ).text(rolls_array[1])
    // $( "#die3" ).text(rolls_array[2])
    // $( "#die4" ).text(rolls_array[3])
    // $( "#die5" ).text(rolls_array[4])



});