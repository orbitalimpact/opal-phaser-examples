require 'opal'
require 'opal-phaser'

class TweenAnImage
  def initialize
    preload = proc do
      @game.load.image('einstein', 'assets/pics/ra_einstein.png')
    end

    create = proc do
      sprite = @game.add.sprite(-400, 0, 'einstein')
      tween  = @game.add.tween(sprite)
      tween.to(`{ x: 600 }`, 6000)
      tween.start
    end

    state = `{ preload: preload, create: create }`
    @game = Opal::Phaser::Game.new(800, 600, Opal::Phaser::CANVAS, 'phaser-example', state )
  end
end
