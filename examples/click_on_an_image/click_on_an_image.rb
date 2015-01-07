require 'opal'
require 'opal/phaser'

class Counter
  attr_reader :count

  def initialize
    @count = 0
  end

  def add
    @count += 1
  end

  def to_s
    "You clicked #{count} times"
  end
end

module Entity
  class Einstein
    attr_reader :sprite_url, :sprite_key

    def initialize
      @sprite_url = 'assets/pics/ra_einstein.png'
      @sprite_key = 'einstein'
    end
  end
end

class ClickOnAnImage
  attr_reader :einstein, :counter, :game

  def initialize
    @einstein = Entity::Einstein.new
    @counter = Counter.new
  end

  def run
    preload_game
    create_game
    Phaser::Game.new(800, 600, Phaser::AUTO, '', state)
  end

  private

  def preload_game
    state.preload do |game|
      @game = game
      game.load.image(einstein.sprite_key, einstein.sprite_url)
    end
  end

  def create_game
    state.create do
      image.anchor.set(0.5)
      image.inputEnabled = true
      image.events.onInputDown.add(listener, self)
    end
  end

  def image
    @image ||= game.add.sprite(game.world.centerX, game.world.centerY, einstein.sprite_key)
  end

  def text
    @text ||= game.add.text(250, 16, '', `{ fill: '#ffffff' }`)
  end

  def listener
    proc {
      counter.add
      text.text = counter.to_s
    }
  end

  def state
    @state ||= Phaser::State.new
  end
end
