require 'opal'
require 'opal-phaser'

class Image
  def initialize(game)
    @sprite_key = "einstein"
    @sprite_url = "assets/pics/ra_einstein.png"
    @game       = game
  end
  
  def preload
    @game.load.image(@sprite_key, @sprite_url)
  end
  
  def create
    sprite = @game.add.sprite(-400, 0, @sprite_key)
    tween  = @game.add.tween(sprite)
    
    tween.to({ x: 600 }, 6000)
    tween.start
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
    @image = Image.new(game)
    @image.preload
  end
  
  def create
    @image.create
  end
end

Game.new
require 'opal'
require 'opal-phaser'

class Image
  def initialize(game)
    @sprite_key = "einstein"
    @sprite_url = "assets/pics/ra_einstein.png"
    @game       = game
  end
  
  def preload
    @game.load.image(@sprite_key, @sprite_url)
  end
  
  def create
    sprite = @game.add.sprite(-400, 0, @sprite_key)
    tween  = @game.add.tween(sprite)
    
    tween.to({ x: 600 }, 6000)
    tween.start
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
    @image = Image.new(game)
    @image.preload
  end
  
  def create
    @image.create
  end
end

Game.new