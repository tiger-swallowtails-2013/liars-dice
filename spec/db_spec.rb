require 'sinatra'
require 'rack/test'
require 'rspec'
require_relative '../config'

def app
  Sinatra::Application
end

RSpec.configure do |config|
  config.before(:suite) do
    Player.destroy_all
    Game.destroy_all
  end
end

def create_game_with_n_players(n)
  game = Game.create
  n.times do
    game.players << Player.create
  end
end

def next_player(game)
  current_player = (game.players.all.sort_by &:updated_at).first
  current_player.updated_at = Time.now
  current_player
end

describe 'game-database setup' do
  it 'should assign players to a new game' do
    create_game_with_n_players(3)
    new_game = Game.all.last
    new_game.players.all.each do |player|
      expect(player.game_id).to eq(new_game.id)
    end
  end
  it 'should initialize players with dice' do
    create_game_with_n_players(3)
    new_game = Game.all.last
    new_game.players.all.each do |player|
      expect(player.number_of_dice).to eq(5)
    end
  end
  it 'should only allow player to belong to one game' do
    p = Player.create
    g1 = Game.create
    g2 = Game.create
    g1.players << p
    g2.players << p
    expect(p.game_id).to eq(g2.id)
  end
end

describe 'game sequence' do
  it 'should pick player with oldest update_at to be current_player' do
    create_game_with_n_players(3)
    new_game = Game.all.last
    new_game.players.all.each do |player|
      expect(player).to eq(next_player(new_game))
    end
  end
end

describe 'player claim' do
  it 'should be in correct format and die-range, e.g. "2x5"' do
    p1 = Player.create(:current_claim => "5x2")
    expect(p1).to be_persisted
  end
  it 'should not save to database if formatted incorrectly' do
    bad_claims = ["6x5","2x7","0x2","Fx3", "1x0", "true", "nil", "FTW"]
    bad_claims.each do |bad_claim|
      expect(Player.create(:current_claim => bad_claim)).not_to be_persisted
    end
  end
end
