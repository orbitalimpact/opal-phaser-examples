require 'opal'
require 'opal-phaser'

class Bot
  def initialize(game)
    @sprite_key = "bot"
    @sprite_url = "assets/sprites/running_bot.png"
    @json_url   = "assets/sprites/running_bot.json"
    @game       = game
  end
  
  def preload
    @game.load.atlasJSONArray(@sprite_key, @sprite_url, @json_url)
  end
  
  def create
    bot = @game.add.sprite(200, 200, @sprite_key)
    
    bot.animations.add("run")
    
    bot.animations.play("run", 15, true)
  end
end

class Game
  def initialize
    preload
    create_game
    
    Phaser::Game.new(width: 800, height: 600, renderer: Phaser::AUTO, parent: "example", state: state, transparent: false, antialias: true, physics: nil)
  end
  
  def preload
    state.preload do |game|
      initialize_entites(game)
      @bot.preload
    end
  end
  
  def create_game
    state.create do
      @bot.create
    end
  end
  
  def state
    @state ||= Phaser::State.new
  end
  
  def initialize_entites(game)
    @bot = Bot.new(game)
  end
end