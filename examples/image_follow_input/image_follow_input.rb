require 'opal'
require 'opal-phaser'

class ImageFollowInput
    def initialize
        state = Phaser::State.new
        state.preload do |game|
            game.load.image("phaser", "assets/sprites/phaser.png")
        end
        
        state.create do |game|
            # we won't do anything... yet
        end
        
        state.update do |game|
            # same here
        end
        
        @phaser = Phaser::Game.new(800, 600, Phaser::AUTO, '', state)
    end
end
