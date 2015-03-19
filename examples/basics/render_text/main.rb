require 'opal'
require 'opal-phaser'

class Text
  def initialize(game)
    @game = game
  end
  
  def create
    text  = "- phaser -\n with a sprinkle of \n pixi dust."
    style = { font: "65px Arial", fill: "#ff0044", align: "center" }
  
    rendered_text = @game.add.text(@game.world.x_center - 300, 0, text, style)
  end
end

class Game
  def initialize
    create_game
    
    Phaser::Game.new(width: 800, height: 600, renderer: Phaser::CANVAS, parent: "example", state: state, transparent: false, antialias: true, physics: nil)
  end
  
  def create_game
    state.create do |game|
      initialize_entities(game)
      
      @text.create
    end
  end
  
  def state
    @state ||= Phaser::State.new
  end
  
  def initialize_entities(game)
    @text = Text.new(game)
  end
end