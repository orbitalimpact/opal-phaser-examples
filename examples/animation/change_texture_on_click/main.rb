require 'opal'
require 'opal-phaser'

class Sprite
  
  attr_accessor :bot
  attr_accessor :mummy_key
  
  def initialize(game)
    @bot_key      = "bot"
    @bot_img_url  = "assets/sprites/running_bot.png"
    @bot_json_url = "assets/sprites/running_bot.json"
    
    @mummy_key = "mummy"
    @mummy_url = "assets/sprites/metalslug_mummy37x45.png"
    
    @game = game
  end
  
  def preload
    @game.load.atlasJSONArray(@bot_key, @bot_img_url, @bot_json_url)
    @game.load.spritesheet(@mummy_key, @mummy_url, 37, 45, 18)
  end
  
  def create
    @bot = @game.add.sprite(200, 200, @bot_key)
    @bot.animations.add("run")
    @bot.animations.play("run", 15, true)
  end
end

class Game
  def initialize
    game  = Phaser::Game.new(width: 800, height: 600, renderer: Phaser::CANVAS, parent: "example")
    state = MainState.new(game)
    game.state.add(:main, state, true)
  end
end

class MainState < Phaser::State
  def initialize(game)
    @sprite = Sprite.new(game)
    @game   = game
  end
  
  def preload
    @sprite.preload
  end
  
  def create
    texture_counter = 0
    
    change_to_mummy = proc do
      if texture_counter == 0
        @sprite.bot.load_texture(@sprite.mummy_key)
        @sprite.bot.animations.add("walk")
        @sprite.bot.animations.play("walk", 30, true)
        texture_counter += 1
      end
    end
    
    @sprite.create
    
    @game.input.on(:down, &change_to_mummy)
  end
  
  def render
    @game.debug.body(@sprite.bot)
  end
end 

Game.new