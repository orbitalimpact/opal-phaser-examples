require 'opal'
require 'opal-phaser'

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

class Sprites
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
    @background            = Background.new(game)
    @sprites               = Sprites.new(game)
    
    @game                  = game
    @sprites_frames        = []
    
    @frame_generator_data  = {"blue_jellyfish_frames" => ["blueJellyfish", 32], "crab_frames" => ["crab1", 25], "green_jellyfish_frames" => ["greenJellyfish", 39], "octopus_frames" => ["octopus", 24], "purple_fish_frames" => ["purpleFish", 20], "seahorse_frames" => ["seahorse", 5], "stingray_frames" => ["stingray", 23]}
    @sprite_generator_data = {"blue_jellyfish" => [670, 20], "crab" => [550, 480], "green_jellyfish" => [330, 100], "octopus" => [160, 400], "purple_fish" => [800, 413], "seahorse" => [491, 40], "stingray" => [80, 190]}
    @tween_generator_data  = {"purple_fish" => [{x: -200}, 7500, false], "octopus" => [{y: 530}, 2000, true], "green_jellyfish" => [{y: 250}, 4000, true], "blue_jellyfish" => [{y: 100}, 8000, true]}
  end
  
  def preload
    @background.preload
    @sprites.preload
  end
  
  def create
    @game.add.image(0, 0, @background.undersea_key)
    
    @frame_generator_data.each do |name, frame_data|
      current_variable_name = "@#{name}"
      current_variable_data = Phaser::Animation.generate_frame_names(prefix: frame_data[0], start_num: 0, stop_num: frame_data[1], suffix: "", zeros_padding: 4)
      
      instance_variable_set(current_variable_name, current_variable_data)
      
      current_variable = instance_variable_get(current_variable_name)
      @sprites_frames.push(current_variable)
    end
    
    frames_counter = 0
    
    @sprite_generator_data.each do |name, positions|
      current_variable_name = "@#{name}"
      current_variable_data = @game.add.sprite(positions[0], positions[1], "seacreatures")
      
      instance_variable_set(current_variable_name, current_variable_data)
      
      current_variable = instance_variable_get(current_variable_name)
      
      current_variable.animations.add("swim", @sprites_frames[frames_counter], 30, true)
      current_variable.animations.play("swim")
      frames_counter += 1
    end
    
    @squid       = @game.add.sprite(610, 215, "seacreatures", "squid0000")
    @flying_fish = @game.add.sprite(60, 40, "seacreatures", "flyingFish0000")
    
    @game.add.image(0, 466, @background.coral_key)
    
    @tween_generator_data.each do |name, tween_data|
      current_sprite = instance_variable_get("@#{name}")
      
      @game.add.tween(current_sprite).to(properties: tween_data[0], duration: tween_data[1], ease: Phaser::Easing::Quadratic.InOut, auto_start: true, repeat: 1000, yoyo: tween_data[2])
    end
  end
end

Game.new