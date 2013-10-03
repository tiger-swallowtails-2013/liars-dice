 describe("load functions", function() {
  var input,
      n_dice,
      diename;

  beforeEach(function() {
    n_dice = 5;
    input = $("<input id='roll_btn' data-dice-count='" + n_dice + "'>");
    $(document.body).append(input);

    for (var i=0; i<n_dice; i++) {
      diename = "die" + (i + 1)
      $('<span/>', {
        id: diename,
        text: "yes! " + i
      }).appendTo(document.body)
    }
  });

  afterEach(function() {
    $('#roll_btn').remove();
    for (var i=0; i<n_dice; i++) {
      diename = "#die" + (i + 1)
      $(diename).remove();
    }
  });

  it("gets data from jquery html data element", function() {
    var number_of_dice = $('#roll_btn').data('dice-count');
    expect(number_of_dice).toEqual(5);
  });

  it("returns a correctly sized array from dice roll", function() {
    var number_of_dice = $('#roll_btn').data('dice-count');
    var rolls = roll_dice(number_of_dice)
    expect(rolls.length).toEqual(number_of_dice)
  });

  it("correctly prints die rolls on document", function() {
    var rolls = roll_dice(n_dice);
    print_dice(rolls)
    var element1_text = $('#die1').text()
    expect(element1_text).toEqual((rolls[0]).toString())
    var element2_text = $('#die2').text()
    expect(element2_text).toEqual((rolls[1]).toString())
    var element3_text = $('#die3').text()
    expect(element3_text).toEqual((rolls[2]).toString())
    var element4_text = $('#die4').text()
    expect(element4_text).toEqual((rolls[3]).toString())
    var element5_text = $('#die5').text()
    expect(element5_text).toEqual((rolls[4]).toString())
  });

});