require 'opal'
require 'opal-phaser'

class LoadAnAnimation
  def initialize
    preload = proc do
      @game.native.load.atlasJSONHash('bot',
                                      'assets/sprites/running_bot.png',
                                      'assets/sprites/running_bot.json')
    end

    create = proc do
      bot = @game.native.add.sprite(200, 200, 'bot')
      bot.native.animations.add('run')
      bot.native.animations.play('run', 15, true)
    end

    state = `{ preload: preload, create: create }`
    @game = Opal::Phaser::Game.new(800, 600, Opal::Phaser::AUTO, 'phaser-example', state)
  end
end
