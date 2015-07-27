require 'opal'
require 'opal-phaser'

class DynamicCrop < Phaser::State
  def preload
    game.load.image('trsi', 'assets/pics/trsipic1_lazur.jpg')
  end

  def create
    @pic = game.add.sprite(0, 0, 'trsi')
    $pic = @pic

    @w = @pic.width
    @h = @pic.height

    @rect = Phaser::Rectangle.new(0, 0, 128, 128)
    $rect = @rect

    @pic.crop(@rect)
  end

  def update
    if (game.input.x < @w && game.input.y < @h)
      @pic.x = game.input.x
      @pic.y = game.input.y
      @rect.x = game.input.x
      @rect.y = game.input.y

      @pic.update_crop
    end
  end
end

class Game
  def initialize
    game  = Phaser::Game.new(width: 800, height: 600, renderer: Phaser::AUTO, parent: "example")
    state = DynamicCrop.new(game)
    game.state.add(:main, state, true)
  end
end

Game.new
