require 'opal'
require 'opal-phaser'

class TweenAnImage
    def initialize
        state = Phaser::State.new
        state.preload do |game|
            game.load.image('einstein', 'assets/pics/ra_einstein.png')
        end
        
        state.create do |game|
            sprite = game.add.sprite(-400, 0, 'einstein')
            tween = game.add.tween(sprite)
            tween.to( {x: 600}, 6000 )
            tween.start
        end
        
        @phaser = Phaser::Game.new(800, 600, Phaser::CANVAS, 'example', state)
    end
end
