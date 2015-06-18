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
    game  = Phaser::Game.new(width: 800, height: 600, renderer: Phaser::CANVAS, parent: "example")
    state = MainState.new(game)
    game.state.add(:main, state, true)
  end
end

class MainState < Phaser::State
  def initialize(game)
    @game = game
  end
  
  def create
    @text = Text.new(game)
    @text.create
  end
end