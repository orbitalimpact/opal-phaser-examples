require 'opal'
require 'opal-phaser'

class ImageFollowInput
  def initialize
    preload = proc do
      @game.load.image('phaser', 'assets/sprites/phaser.png')
    end

    create = proc do
      @game.physics.startSystem(Opal::Phaser::Physics::ARCADE)
      @sprite = @game.add.sprite(@game.world.centerX, @game.world.centerY, 'phaser')
      @sprite.anchor.set(0.5)
      @game.physics.arcade.enable(@sprite)
    end

    update = proc do
      distance_to_pointer = @game.physics.arcade.distanceToPointer(@sprite, @game.input.activePointer)

      if distance_to_pointer > 8
        @game.physics.arcade.moveToPointer(@sprite, 300)
      else
        @sprite.body.velocity.set(0)
      end
    end

    render = proc do
      @game.debug.inputInfo(32, 32)
    end

    state = `{ preload: preload, create: create, update: update, render: render }`
    @game = Opal::Phaser::Game.new(800, 600, Opal::Phaser::AUTO, 'phaser-example', state )
  end
end
