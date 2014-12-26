require 'opal'
require 'opal-phaser'

class ClickOnAnImage
  def initialize
    @counter = 0

    listener = proc do
      @counter += 1
      @text.text = "You clicked #{@counter} times"
    end

    preload = proc do
      @game.load.image('einsten', 'assets/pics/ra_einstein.png')
    end

    create = proc do
      image = @game.add.sprite(@game.world.centerX, @game.world.centerY, 'einsten')
      image.anchor.set(0.5)
      image.inputEnabled = true
      @text = @game.add.text(250, 16, '', `{ fill: '#ffffff' }`)

      image.events.onInputDown.add(listener.to_n, self)
    end

    state = `{ preload: preload, create: create }`
    @game = Opal::Phaser::Game.new(800, 600, Opal::Phaser::CANVAS, 'phaser-example', state )
  end
end
