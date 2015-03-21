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
    @counter = 0
    
    listener = proc do
      @counter   += 1
      @text.text = "You clicked #{@counter} times!"
    end
    
    @image = @game.add.sprite(@game.world.x_center, @game.world.y_center, @sprite_key)
    @image.anchor.set(0.5)
    
    @image.input_enabled = true
    
    @text = @game.add.text(250, 16, '', { fill: '#ffffff' })
    
    @image.events.on_input_down.add(listener)
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
      entities_call :preload
    end
  end
  
  def create_game
    state.create do
      entities_call :create
    end
  end
  
  def state
    @state ||= Phaser::State.new
  end
  
  def initialize_entities(game)
    @image = Image.new(game)
  end
  
  def entities_call(method)
    @image.send(method)
  end
end