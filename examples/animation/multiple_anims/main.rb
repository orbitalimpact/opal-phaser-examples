require 'opal'
require 'opal-phaser'
require 'pp'

class Background
  attr_reader :undersea_key
  attr_reader :coral_key
  
  def initialize(game)
    @undersea_key = "undersea"
    @undersea_url = "assets/pics/undersea.jpg"
    
    @coral_key    = "coral"
    @coral_url    = "assets/pics/seabed.png"
    
    @game         = game
  end
  
  def preload
    @game.load.image(@undersea_key, @undersea_url)
    @game.load.image(@coral_key,    @coral_url)
  end
end

class SpritesLoader
  def initialize(game)
    @game    = game
    @img_key = 'seacreatures'
    @img_url = 'assets/sprites/seacreatures.png'
    @xml_url = 'assets/sprites/seacreatures.xml'
  end
  
  def preload
    @game.load.atlasXML(@img_key, @img_url, @xml_url)
  end
end

class Game
  def initialize
    game = Phaser::Game.new(width: 800, height: 600, renderer: Phaser::AUTO, parent: "example")
    state = MainState.new(game)
    game.state.add(:main, state, true)
  end
end

class MainState < Phaser::State
  def initialize(game)
    @background     = Background.new(game)
    @sprites_loader = SpritesLoader.new(game)
    
    @game           = game
    @frames_data    = {"blue_jellyfish_frames" => ["blueJellyfish", 32], "crab_frames" => ["crab1", 25], "green_jellyfish_frames" => ["greenJellyfish", 39], "octopus_frames" => ["octopus", 24], "purple_fish_frames" => ["purpleFish", 20], "seahorse_frames" => ["seahorse", 5], "stingray_frames" => ["stingray", 23]}
    @sprites_frames = []
    
    @sprites_data   = {"blue_jellyfish" => [670, 20], "crab" => [550, 480], "green_jellyfish" => [330, 100], "octopus" => [160, 400], "purple_fish" => [800, 413], "seahorse" => [491, 40], "stingray" => [80, 190]}
    
    @tweens_data    = {"purple_fish" => [{x: -200}, 7500, false], "octopus" => [{y: 530}, 2000, true], "green_jellyfish" => [{y: 250}, 4000, true], "blue_jellyfish" => [{y: 100}, 8000, true]}
  end
  
  def preload
    @background.preload
    @sprites_loader.preload
  end
  
  def create
    @game.add.image(0, 0, @background.undersea_key)
    
    @frames_data.each do |name, data|
      instance_variable_set("@#{name}", Phaser::Animation.generate_frame_names(prefix: data.first, start_num: 0, stop_num: data.last, suffix: "", zeros_padding: 4))
      @sprites_frames.push(instance_variable_get("@#{name}"))
    end
    
    sprite_counter = 0
    
    @sprites_data.each do |sprite, position|
      instance_variable_set("@#{sprite}", @game.add.sprite(position.first, position.last, "seacreatures"))
      instance_variable_get("@#{sprite}").animations.add("swim", @sprites_frames[sprite_counter], 30, true)
      instance_variable_get("@#{sprite}").animations.play('swim')
      sprite_counter += 1
    end
    
    @squid       = @game.add.sprite(610, 215, "seacreatures", "squid0000")
    @flying_fish = @game.add.sprite(60, 40, "seacreatures", "flyingFish0000")
    
    @game.add.image(0, 466, @background.coral_key)
    
    @tweens_data.each do |sprite, data|
      @game.add.tween(instance_variable_get("@#{sprite}")).to(data[0], data[1], Phaser::Easing::Quadratic.InOut, true, 0, 1000, data[2])
    end
  end
end