require 'opal'
require 'opal-phaser'

class RenderText
    def initialize
        state = Phaser::State.new
        state.create do |game|
            text = "- phaser -\n with a sprinkle of \n pixi dust."
            style = { :font => "65px Arial", :fill => "#ff0044", :align => "center" }
            
            t = game.add.text(game.world.centerX - 300, 0, text, style)
        end
        
        @phaser = Phaser::Game.new(800, 600, Phaser::AUTO, 'example', state)
    end
end