require 'opal'
require 'opal-phaser'
require 'pp'

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
    pp @sprites
    @game.time.events.loop(50, create_sprite)
  end
  
  def update
    check_sprite = proc do |sprite|
      if `sprite.x` > @game.width
        @rip += 1
        @sprites.remove(sprite, true)
      end
    end
    
    @sprites.set_all("x", 10, true, true, 1)
    @sprites.for_each(check_sprite, self, true)
  end
  
  def render
    @game.debug.text("Group size: #{@sprites.total}", 32, 32)
    @game.debug.text("Destroyed: #{@rip}", 32, 64)
  end
end

class Game
  def initialize
    preload
    create
    update
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
      @sprite.create
    end
  end
  
  def update
    state.update do |game|
      @sprite.update
    end
  end
  
  def render
    state.render do |game|
      @sprite.render
    end
  end
end