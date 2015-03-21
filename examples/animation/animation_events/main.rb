require 'opal'
require 'opal-phaser'

class Background
  attr_reader :background
  
  def initialize(game)
    @sprite_key = "lazur"
    @sprite_url = "assets/pics/thorn_lazur.png"
    @game       = game
  end
  
  def preload
    @game.load.image(@sprite_key, @sprite_url)
  end
  
  def create
    @background = @game.add.image(0, -400, @sprite_key)
    @background.scale.set(2)
    @background.smoothed = false
  end
end

class Mummy
  attr_reader :anim
  
  def initialize(game)
    @sprite_key    = "mummy"
    @sprite_url    = "assets/sprites/metalslug_mummy37x45.png"
    @animation_key = "walk"
    @game          = game
  end
  
  def preload
    @game.load.spritesheet(@sprite_key, @sprite_url, 37, 45, 18)
  end
  
  def create
    animation_started = proc do
      @game.add.text(32, 32, "Animation started", { fill: "white" })
    end
    
    animation_looped = proc do
      if @anim.loop_count == 1
        @loop_text = @game.add.text(32, 64, "Animation looped", { fill: "white" })
      else
        @loop_text.text = "Animation looped x2"
        @anim.loop = false
      end
    end
    
    animation_completed = proc do
      @game.add.text(32, 64 + 32, "Animation stopped", { fill: "white" })
    end
    
    mummy = @game.add.sprite(200, 360, @sprite_key, 5)
    mummy.scale.set(4)
    mummy.smoothed = false
    
    @anim = mummy.animations.add("walk")
    @anim.on_start.add(animation_started)
    @anim.on_loop.add(animation_looped)
    @anim.on_completion.add(animation_completed)
    
    @anim.play(10, true)
  end
end

class Game
  def initialize
    preload
    create
    update
    
    Phaser::Game.new(width: 800, height: 600, renderer: Phaser::CANVAS, parent: "example", state: state, transparent: false, antialias: true, physics: nil)
  end
  
  def preload
    state.preload do |game|
      initialize_entities(game)
      
      entities_call :preload
    end
  end
  
  def create
    state.create do
      entities_call :create
    end
  end
  
  def update
    state.update do
      if @mummy.anim.is_playing?
        @background.background.x -= 1
      end
    end
  end
  
  def state
    @state ||= Phaser::State.new
  end
  
  def initialize_entities(game)
    @background = Background.new(game)
    @mummy      = Mummy.new(game)
    
    @entities = [@background, @mummy]
  end
  
  def entities_call(method)
    @entities.each do |entity|
      entity.send(method)
    end
  end
end