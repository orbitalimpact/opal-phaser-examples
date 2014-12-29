require 'opal'
require 'opal-phaser'

class ClickOnAnImage
    def initialize
        @text = nil
        @counter = 0
        
        @phaser = Phaser::Game.new(800, 600) do |state|
            
            state.preload do |game|
                game.load.image("einstein", "assets/pics/ra_einstein.png")
            end
            
            listener = Proc.new do
                @counter += 1
                @text.text = "You clicked #{@counter} times!"
            end
            
            state.create do |game|
                @image = game.add.sprite(game.world.centerX, game.world.centerY, "einstein")
                
                @image.anchor.set(0.5)
                
                @image.inputEnabled = true
                
                @text = game.add.text(250, 16, '', { fill: "#ffffff" })
                
                @image.events.onInputDown.add(listener)
            end
        end
    end
end
