require 'opal'
require 'opal-phaser'

class RenderAText
  def initialize
    create = proc do
      text = "- phaser -\n with a sprinkle of \n pixi dust."
      style = `{ font: "65px Arial", fill: "#ff0044", align: "center" }`
      @game.add.text(@game.world.centerX-300, 0, text, style)
    end

    state = `{ create: create }`
    @game = Opal::Phaser::Game.new(800, 600, Opal::Phaser::CANVAS, 'phaser-example', state )
  end
end
