require 'opal'
require 'opal-phaser'

class MoveAnImage
  def initialize
    preload = proc do
      @game.load.image('einsten', 'assets/pics/ra_einstein.png')
    end

    create = proc do
      image = @game.add.sprite(0, 0, 'einsten')
      @game.physics.enable(image, Opal::Phaser::Physics::ARCADE)
      image.body.velocity.x = 150
    end

    state = `{ preload: preload, create: create }`
    @game = Opal::Phaser::Game.new(800, 600, Opal::Phaser::CANVAS, 'phaser-example', state )
  end
end
