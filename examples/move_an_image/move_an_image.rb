require 'opal'
require 'opal-phaser'

class MoveAnImage
    def initialize
        state = Phaser::State.new
        state.preload do |game|
            game.load.image('einsten', 'assets/pics/ra_einstein.png')
        end
      
        state.create do |game|
            image = game.add.sprite(0, 0, 'einsten')
            game.physics.enable(image, Phaser::Physics::ARCADE)
            image.body.velocity.x = 150
        end
      
        @phaser = Phaser::Game.new(800, 600, Phaser::AUTO, 'example', state)
    end
end
