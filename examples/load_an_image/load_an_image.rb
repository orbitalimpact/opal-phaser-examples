require 'opal'
require 'opal-phaser'

class LoadAnImage
    def initialize
        state = Phaser::State.new
        state.preload do |game|
            game.load.image("einstein", "assets/pics/ra_einstein.png")
        end
        
        state.create do |game|
            game.add.sprite(0, 0, "einstein")
        end
        
        @phaser = Phaser::Game.new(800, 600, Phaser::CANVAS, 'example', state)
    end
end
