class Einstein
  attr_reader :sprite_url, :sprite_key, :game

  def initialize(game)
    @sprite_url = 'assets/pics/ra_einstein.png'
    @sprite_key = 'einstein'
    @game = game
  end

  def place
    sprite.anchor.set(0.5)
    sprite.inputEnabled = true
  end

  def add_listener(listener)
    sprite.events.onInputDown.add(listener, self)
  end

  private

  def centerX
    game.world.centerX
  end

  def centerY
    game.world.centerY
  end

  def sprite
    @sprite ||= game.add.sprite(centerX, centerY, sprite_key)
  end
end
