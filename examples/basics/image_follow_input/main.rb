require 'opal'
require 'opal-phaser'

class Logo
  def initialize(game)
    @sprite_key = "phaser"
    @sprite_url = "assets/sprites/phaser.png"
    @game       = game
  end
  
  def preload
    @game.load.image(@sprite_key, @sprite_url)
  end
  
  def create
    @speed_to_pointer = 300
    @debug_x_pos      = 32
    @debug_y_pos      = 32
    
    @game.physics.start_system(Phaser::Physics::ARCADE)
    
    @sprite = @game.add.sprite(@game.world.x_center, @game.world.y_center, "phaser")
    @sprite.anchor.set(0.5)
    
    @game.physics.arcade.enable(@sprite)
  end
  
  def update
    if @game.physics.arcade.distance_to_pointer(@sprite, @game.input.activePointer) > 8
      @game.physics.arcade.move_to_pointer(@sprite, @speed_to_pointer)
    else
      @sprite.body.velocity.set(0)
    end
  end
  
  def render
    @game.debug.inputInfo(@debug_x_pos, @debug_y_pos)
  end
end

class Game
  def initialize
    preload
    create_game
    update_game
    render
    
    Phaser::Game.new(width: 800, height: 600, renderer: Phaser::AUTO, parent: "example", state: state, transparent: false, antialias: true, physics: nil)
  end
  
  def preload
    state.preload do |game|
      initialize_entities(game)
      entities_call :preload
    end
  end
  
  def create_game
    state.create do
      entities_call :create
    end
  end
  
  def update_game
    state.update do
      entities_call :update
    end
  end
  
  def render
    state.render do
      entities_call :render
    end
  end
  
  def state
    @state ||= Phaser::State.new
  end
  
  def initialize_entities(game)
    @image = Logo.new(game)
  end
  
  def entities_call(method)
    @image.send(method)
  end
end