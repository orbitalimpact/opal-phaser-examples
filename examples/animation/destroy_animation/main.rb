require 'opal'
require 'opal-phaser'

class Sprite
  def initialize(game)
    @sprite_key    = "mummy"
    @sprite_url    = "assets/sprites/metalslug_mummy37x45.png"
    @frames_width  = 37
    @frames_height = 45
    @max_frames    = 18
    
    @game          = game
    @rip           = 0
  end
  
  def preload
    @game.load.spritesheet(@sprite_key, @sprite_url, @frames_width, @frames_height, @max_frames)
  end
  
  def create
    create_sprite = proc do
      mummy = @sprites.create(0, @game.world.random_y, "mummy")
      mummy.animations.add("walk")
      mummy.play("walk", 10, true)
    end
    
    @sprites = @game.add.group
    @game.time.events.loop(50, create_sprite)
  end
  
  def update
    @sprites.set_all("x", 10, true, true, 1)
    
    @sprites.children.each do |sprite|
      if `sprite.x > self.game.$width()`
        @rip += 1
        @sprites.remove(sprite, true)
      end
    end
  end
  
  def render
    @game.debug.text("Group size: #{@sprites.total}", 32, 32)
    @game.debug.text("Destroyed: #{@rip}", 32, 64)
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
  end
  
  methods = [:preload, :create, :update, :render]
  
  methods.each do |method|
    define_method(method) do
      @sprite.send method
    end
  end
end

Game.new
require 'opal'
require 'opal-phaser'

class Sprite
  def initialize(game)
    @sprite_key    = "mummy"
    @sprite_url    = "assets/sprites/metalslug_mummy37x45.png"
    @frames_width  = 37
    @frames_height = 45
    @max_frames    = 18
    
    @game          = game
    @rip           = 0
  end
  
  def preload
    @game.load.spritesheet(@sprite_key, @sprite_url, @frames_width, @frames_height, @max_frames)
  end
  
  def create
    create_sprite = proc do
      mummy = @sprites.create(0, @game.world.random_y, "mummy")
      mummy.animations.add("walk")
      mummy.play("walk", 10, true)
    end
    
    @sprites = @game.add.group
    @game.time.events.loop(50, create_sprite)
  end
  
  def update
    @sprites.set_all("x", 10, true, true, 1)
    
    @sprites.children.each do |sprite|
      if `sprite.x > self.game.$width()`
        @rip += 1
        @sprites.remove(sprite, true)
      end
    end
  end
  
  def render
    @game.debug.text("Group size: #{@sprites.total}", 32, 32)
    @game.debug.text("Destroyed: #{@rip}", 32, 64)
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
  end
  
  methods = [:preload, :create, :update, :render]
  
  methods.each do |method|
    define_method(method) do
      @sprite.send method
    end
  end
end

Game.new