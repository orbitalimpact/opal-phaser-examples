require 'opal'
require 'opal-phaser'

class LoadAnImage
  def initialize
    preload = proc do
      @game.load.image('einsten', 'assets/pics/ra_einstein.png')
    end

    create = proc do
      @game.add.sprite(0, 0, 'einsten')
    end

    state = `{ preload: preload, create: create }`
    @game = Opal::Phaser::Game.new(800, 600, Opal::Phaser::CANVAS, 'phaser-example', state )
  end
end
