require 'opal'
require 'opal-phaser'

class AnimationEvents
    def initialize
        state = Phaser::State.new
        state.preload do |game|
            game.load.image('lazur', 'assets/pics/thorn_lazur.png')
            game.load.spritesheet('mummy', 'assets/sprites/metalslug_mummy37x45.png', 37, 45, 18)
        end
        
        state.create do |game|
            animationStarted = Proc.new do |sprite, animation|
                game.add.text(32, 32, 'Animation started', { :fill => 'white' })
            end
            
            animationLooped = Proc.new do |sprite, animation|
                if animation.loopCount == 1
                    loopText = game.add.text(32, 64, 'Animation looped', { :fill => 'white' })
                else
                    loopText.text = 'Animation looped x2'
                    animation.loop = false
                end
            end
            
            animationStopped = Proc.new do |sprite, animation|
                game.add.text(32, 64 + 32, 'Animation stopped', { :fill => 'white' })
            end
            
            game.stage.smoothed = false
            
            back = game.add.image(0, -400, 'lazur')
            back.scale.set(2)
            
            mummy = game.add.sprite(200, 360, 'mummy', 5)
            mummy.scale.set(4)
            anim = mummy.animations.add('walk')
            
            anim.onStart.add(animationStarted)
            anim.onLoop.add(animationLooped)
            anim.onComplete.add(animationStopped)
            
            anim.play(10, true)
        end
        
        
        
        @phaser = Phaser::Game.new(800, 600, Phaser::CANVAS, 'example', state)
    end
end