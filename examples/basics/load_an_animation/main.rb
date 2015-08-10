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
    game  = Phaser::Game.new(width: 800, height: 600, renderer: Phaser::AUTO, parent: "example")
    state = MainState.new(game)
    game.state.add(:main, state, true)
  end
end

class MainState < Phaser::State
  def initialize(game)
    @game = game
  end
  
  def preload
    @bot = Bot.new(@game)
    @bot.preload
  end
  
  def create
    @bot.create
  end
end

Game.new
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
    game  = Phaser::Game.new(width: 800, height: 600, renderer: Phaser::AUTO, parent: "example")
    state = MainState.new(game)
    game.state.add(:main, state, true)
  end
end

class MainState < Phaser::State
  def initialize(game)
    @game = game
  end
  
  def preload
    @bot = Bot.new(@game)
    @bot.preload
  end
  
  def create
    @bot.create
  end
end

Game.new