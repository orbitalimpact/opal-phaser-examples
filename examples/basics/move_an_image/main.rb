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
    image = @game.add.sprite(0, 0, @sprite_key)
    @game.physics.arcade.enable(image)
    image.body.velocity.x = 150
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
      initialize_entities(game)
      
      @image.preload
    end
  end
  
  def create_game
    state.create do
      @image.create
    end
  end
  
  def state
    @state ||= Phaser::State.new
  end
  
  def initialize_entities(game)
    @image = Image.new(game)
  end
end