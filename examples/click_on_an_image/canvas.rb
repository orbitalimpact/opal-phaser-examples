require 'components/einstein'
require 'components/counter'

class Canvas
  attr_reader :einstein, :counter, :game

  def initialize(game)
    @game = game
    @einstein = Einstein.new(game)
    @counter = Counter.new(game)
  end

  def load_background
    game.load.image(einstein.sprite_key, einstein.sprite_url)
  end

  def place_components
    einstein.place(listener)
    counter.place
  end

  private

  def listener
    proc {
      counter.add
      counter.update_display
    }
  end
end
