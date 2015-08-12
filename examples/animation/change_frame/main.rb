require 'opal'
require 'opal-phaser'

class Background
  def initialize(game)
    @sprite_key = "undersea"
    @sprite_url = "assets/pics/undersea.jpg"
    @game       = game
  end
  
  def preload
    @game.load.image(@sprite_key, @sprite_url)
  end
  
  def create
    @game.add.image(0, 0, @sprite_key)
  end
end

class GreenJellyFish
  
  attr_reader :green_jelly_fish
  
  def initialize(game)
    @atlas_key  = "seacreatures"
    @atlas_img  = "assets/sprites/seacreatures_json.png"
    @atlas_json = "assets/sprites/seacreatures_json.json"
    @game       = game
  end
  
  def preload
    @game.load.atlas(@atlas_key, @atlas_img, @atlas_json)
  end
  
  def create
    @green_jelly_fish = @game.add.sprite(330, 100, @atlas_key, "greenJellyfish0000")
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
    @background = Background.new(game)
    @fish       = GreenJellyFish.new(game)
    
    @objects    = [@background, @fish]
    @game       = game
  end
  
  def call_state_method(state)
    @objects.each { |object| object.send(state) }
  end
  
  def preload
    call_state_method :preload
  end
  
  def create
    change_frame = proc do
      @fish.green_jelly_fish.frame_name = "greenJellyfish0010"
    end
    
    @game.input.on(:down, &change_frame)
    
    call_state_method :create
  end
end

Game.new