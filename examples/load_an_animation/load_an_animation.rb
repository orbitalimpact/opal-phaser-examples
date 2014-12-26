require 'opal'
require 'opal-phaser'

class LoadAnAnimation
  def initialize
    preload = proc do
      # On original examples uses atlasJSONHash
      # but throw a exception:
      # TypeError: undefined is not an object (evaluating 'g[i].frame.x')
      @game.load.atlasJSONArray('bot',
                                'assets/sprites/running_bot.png',
                                'assets/sprites/running_bot.json')
    end

    create = proc do
      bot = @game.add.sprite(200, 200, 'bot')
      bot.animations.add('run')
      bot.animations.play('run', 15, true)
    end

    state = `{ preload: preload, create: create }`
    @game = Opal::Phaser::Game.new(800, 600, Opal::Phaser::CANVAS, 'phaser-example', state)
  end
end
