require 'opal'
require 'opal/phaser'

class Counter
  attr_reader :counter

  def initialize
    @count = 0
  end

  def add
    @count += 1
  end

  def to_s
    "You clicked #{@count} times"
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
  attr_reader :einstein, :counter
  
  def initialize
    @einstein = Entity::Einstein.new
    @counter = Counter.new
  end

  def run
    Phaser::Game.new(800, 600) do |state|
      state.preload do |game|
        game.load.image(einstein.sprite_key, einstein.sprite_url)
      end

      state.create do |game|
        image = game.add.sprite(game.world.centerX, game.world.centerY, einstein.sprite_key)
        image.anchor.set(0.5)
        text = game.add.text(250, 16, '', `{ fill: '#ffffff' }`)

        listener = proc {
          counter.add
          text.text = counter.to_s
        }

        image.inputEnabled = true
        image.events.onInputDown.add(listener, self)
      end
    end
  end
end
