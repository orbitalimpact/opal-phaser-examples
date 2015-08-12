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
    if @game.physics.arcade.distance_to_pointer(@sprite, @game.input.active_pointer) > 8
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
    @logo = Logo.new(@game)
    @logo.preload
  end
  
  def create
    @logo.create
  end
  
  def update
    @logo.update
  end
  
  def render
    @logo.render
  end
end

Game.new