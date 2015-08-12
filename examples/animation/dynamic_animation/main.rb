require 'opal'
require 'opal-phaser'

class Orb
  def initialize(game)
    @sprite_key = "orb"
    @sprite_url = "assets/sprites/orb-blue.png"
    @game       = game
  end
  
  def preload
    @game.load.image(@sprite_key, @sprite_url)
  end
  
  def create
    @game.stage.background_color = "#ef3d45"
    
    orb = @game.make.sprite(0, 0, @sprite_key)
    bmd = @game.add.bitmap_data(352, 22)
    
    x   = 0
    y   = -22
    
    15.times do
      bmd.draw(orb, x, y)
      x += 22
      y += 3
    end
    
    @game.add.image(0, 0, bmd)
    @game.cache.add_sprite_sheet("dynamic", "", bmd.canvas, 22, 22, 16, 0, 0)
    
    i = 0
    loop do
      i += 1
      test = @game.add.sprite(200, 100 + (i * 22), "dynamic")
      test.animations.add("float")
      test.play("float", 20, true)
      break if i == 16
    end
  end
end

class Game
  def initialize
    game  = Phaser::Game.new(width: 800, height: 600, renderer: Phaser::AUTO, parent: "example")
    state = MainState.new(game)
    game.state.add(:main, state, true)
  end
end

class MainState < Phaser::State
  def initialize(game)
    @orb = Orb.new(game)
  end
  
  def preload
    @orb.preload
  end
  
  def create
    @orb.create
  end
end

Game.new