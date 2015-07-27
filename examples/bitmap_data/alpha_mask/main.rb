require 'opal'
require 'opal-phaser'

class AlphaMask < Phaser::State
  def preload
    game.load.image('pic', 'assets/pics/questar.png');
    game.load.image('mask', 'assets/pics/mask-test2.png');
  end

  def create
    game.stage.background_color = 0x4d4d4d

    game.add.text(64, 10, 'Source image', { font: '16px Arial', fill: '#ffffff' })
    game.add.image(64, 32, 'pic');

    game.add.text(400, 10, 'Alpha mask', { font: '16px Arial', fill: '#ffffff' })
    game.add.image(400, 32, 'mask');

    bmd = game.make.bitmap_data(320, 256);

    bmd.alpha_mask('pic', 'mask');

    game.add.image(game.world.x_center, 320, bmd).anchor.set(0.5, 0);
  end
end

class Game
  def initialize
    game  = Phaser::Game.new(width: 800, height: 600, renderer: Phaser::AUTO, parent: "example")
    state = AlphaMask.new(game)
    game.state.add(:main, state, true)
  end
end
