require 'opal'
require 'opal/phaser'
require 'canvas'

class ClickOnAnImage
  attr_reader :canvas

  def run
    preload
    create_game
    Phaser::Game.new(800, 600, Phaser::AUTO, '', state)
  end

  private

  def preload
    state.preload do |game|
      @canvas = Canvas.new(game)
      canvas.load_background
    end
  end

  def create_game
    state.create do
      canvas.place_components
    end
  end

  def state
    @state ||= Phaser::State.new
  end
end
