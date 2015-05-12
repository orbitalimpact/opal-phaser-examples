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
    preload
    create
    update
    
    Phaser::Game.new(width: 800, height: 600, renderer: Phaser::AUTO, parent: "example", state: state, transparent: false, antialias: true, physics: nil)
  end
  
  def state
    @state ||= Phaser::State.new
  end
  
  def preload
    state.preload do |game|
      @bot = Bot.new(game)
      @bot.preload
    end
  end
  
  def create
    state.create do |game|
      @bot.create
    end
  end
  
  def update
    state.update do |game|
      @bot.update
    end
  end
end