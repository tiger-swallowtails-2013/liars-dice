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

describe 'game database' do
  it 'should assign player an id' do
    p = Player.create
    expect(p1.id).to eq(1)
  end
end


describe 'gameplay data' do
  it 'should assign players to a new game' do
    g1 = Game.create
    p1 = Player.create
    p2 = Player.create
    p3 = Player.create
    g1.players << p1
    g1.players << p2
    g1.players << p3
    expect(p1.game_id).to eq(g1.id)
    expect(p2.game_id).to eq(g1.id)
    expect(p3.game_id).to eq(g1.id)
  end
  it 'should initialize players with dice' do
    expect(p1.number_of_dice).to eq(3)
    expect(p2.number_of_dice).to eq(3)
    expect(p3.number_of_dice).to eq(3)
  end
  it 'should pick player with oldest update_at to be current_player' do
    g1 = Game.create
    p1 = Player.create
    p2 = Player.create
    p3 = Player.create
    g1.players << p1
    g1.players << p2
    g1.players << p3
    p1_time = p1.updated_at
    p2_time = p2.updated_at
    p3_time = p3.updated_at
    def next_player(game)
      return (game.players.all.sort_by &:updated_at).first
    end
      current_player = next_player(g1)
      expect(current_player).to be(p1)
      current_player.updated_at = Time.now
      current_player = next_player(g1)
      expect(current_player).to be(p2)
      current_player.updated_at = Time.now
      current_player = next_player(g1)
      expect(current_player).to be(p3)
      current_player.updated_at = Time.now
  end
end
