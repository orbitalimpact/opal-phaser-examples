require 'opal'
require 'opal-phaser'

class Bot
  def initialize(game)
    @sprite_key        = "bot"
    @sprite_img        = "assets/sprites/running_bot.png"
    @sprite_json       = "assets/sprites/running_bot.json"
    
    @bot_animation_key = "run"
    
    @game              = game
  end
  
  def preload
    @game.load.atlasJSONArray(@sprite_key, @sprite_img, @sprite_json)
  end
  
  def create
    @bot = @game.add.sprite(200, 200, @sprite_key)
    
    @bot.animations.add(@bot_animation_key)
    
    @bot.animations.play(@bot_animation_key, 15, true)
  end
  
  def update
    @bot.x -= 2
    
    if @bot.x < -@bot.width
      @bot.x = @game.world.width
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
    @bot = Bot.new(game)
  end
  
  def preload
    @bot.preload
  end
  
  def create
    @bot.create
  end
  
  def update
    @bot.update
  end
end

Game.new
