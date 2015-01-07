class Counter
  attr_reader :count, :game, :scoreboard

  def initialize(game)
    @game = game
    @count = 0
  end

  def add
    @count += 1
  end

  def update_display
    scoreboard.text = to_s
  end

  def place
    @scoreboard ||= game.add.text(250, 16, '', `{ fill: '#ffffff' }`)
  end

  def to_s
    "You clicked #{count} times"
  end
end
