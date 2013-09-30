# MVP:
* A guest is assigned a session
* A guest can play a game
* A game consists of two players
* A player knows when it's their turn
* A player can roll their dice
* A player can make a claim
* A player can see the most recent claims
* A player can contest a claim
* A claim can be verified
* A player can lose a die
* A game can end / A player can win a game
* Players can start a new game


# USER STORY:
* A guest is assigned a session
* A guest can create a new game
* A guess can join a game
* A player knows when it's their turn
* A player is given dice
* A player can roll their dice on their turn
* A player can make a claim
* A player can view all claims at all times
* A (next) player can contest a claim
* A claim can be verified
* A player can lose a die if caught bullshitting
* A player can lose a die if they contest a claim and are wrong
* A player loses their turn/the game if they have no dice
* A player wins when their opponents have no more dice

# Stretch Goals:
* 2-n players
* Play against computer
* Graphical dice and rolls
* Oauth
* Login with Facebook
* A winner can tweet that they won

Branch Goals
1. Sessions
2. Routes
3. Tests
  - RSpec
  - Jasmine
  - Capybara
4. Basic Database and Tables
  - Users
  - Games (game-id, player-ids)
5. Basic UI
  - Single "shared" page where user can submit form info
  - Second user cannot see, but gets some report on what was submitted
