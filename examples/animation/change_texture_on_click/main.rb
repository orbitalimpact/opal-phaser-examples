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
    preload
    create
    render
    
    Phaser::Game.new(width: 800, height: 600, renderer: Phaser::CANVAS, parent: "example", state: state, transparent: false, antialias: true, physics: nil)
  end
  
  def state
    @state ||= Phaser::State.new
  end
  
  def preload
    state.preload do |game|
      @sprite = Sprite.new(game)
      
      @sprite.preload
    end
  end
  
  def create
    state.create do |game|
      change_to_mummy = proc do
        @sprite.bot.load_texture(@sprite.mummy_key)
        @sprite.bot.animations.add("walk")
        @sprite.bot.animations.play("walk", 30, true)
      end
      
      @sprite.create
      
      game.input.on_down.add_once(change_to_mummy)
    end
  end
  
  def render
    state.render do |game|
      game.debug.body(@sprite.bot)
    end
  end
end