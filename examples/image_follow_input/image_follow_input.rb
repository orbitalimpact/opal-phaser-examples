require 'opal'
require 'opal-phaser'

class ImageFollowInput
    def initialize
        sprite = nil
        
        state = Phaser::State.new
        state.preload do |game|
            game.load.image("phaser", "assets/sprites/phaser.png")
        end
        
        state.create do |game|
            game.physics.arcade.startSystem(Phaser::Physics::ARCADE)
            
            sprite = game.add.sprite(game.world.centerX, game.world.centerY, "phaser")
            sprite.anchor.set(0.5)
            
            game.physics.arcade.enable(sprite)
        end
        
        state.update do |game|
            distance_from_cursor = game.physics.arcade.distanceToPointer(sprite, game.input.activePointer)
            
            if distance_from_cursor > 8
                game.physics.arcade.moveToPointer(sprite, 300)
            else
                sprite.body.velocity.set(0)
            end
        end
        
        state.render do |game|
            game.debug.inputInfo(32, 32)
        end
        
        @phaser = Phaser::Game.new(800, 600, Phaser::AUTO, 'example', state)
    end
end
