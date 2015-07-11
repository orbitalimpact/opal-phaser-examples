require 'opal'
require 'opal-phaser'

class SeaCreatures
  def initialize(game)
    @octopus_key      = "seacreatures"
    @octopus_img_url  = "assets/sprites/seacreatures_json.png"
    @octopus_json_url = "assets/sprites/seacreatures_json.json"
    @undersea_key     = "undersea"
    @undersea_url     = "assets/pics/undersea.jpg"
    @coral_key        = "coral"
    @coral_url        = "assets/pics/seabed.png"
    
    @game             = game
  end
  
  def preload
    @game.load.atlas(@octopus_key, @octopus_img_url, @octopus_json_url)
    @game.load.image(@undersea_key, @undersea_url)
    @game.load.image(@coral_key, @coral_url)
  end
  
  def create
    @game.add.sprite(0, 0, @undersea_key)
    
    group = @game.add.group
    
    i = 0
    loop do
      i += 1
      sprite = group.create(120 * i, @game.rnd.integer_in_range(100, 400), @octopus_key, "octopus0000")
      break if i >= 6
    end
    
    frame_names = []
    
    i = -1
    loop do
      i += 1
  
      if i < 10
        frame_names.push("octopus000#{i}")
      else
        frame_names.push("octopus00#{i}")
      end
  
      break if i == 24
    end
    
    group.call_all("animations.add", "animations", "swim", frame_names, 30, true, false)
    group.call_all("play", nil, "swim")
    
    @game.add.sprite(0, 466, @coral_key)
  end
end

class Game
  def initialize
    game  = Phaser::Game.new(width: 800, height: 600, renderer: Phaser::AUTO, parent: "example")
    state = MainState.new(game)
    game.state.add(:main, state, true)
  end
end

class MainState < Phaser::State
  def initialize(game)
    @sea_creatures = SeaCreatures.new(game)
  end
  
  def preload
    @sea_creatures.preload
  end
  
  def create
    @sea_creatures.create
  end
end

Game.new
