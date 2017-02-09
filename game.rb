require 'pry-byebug'
require 'gosu'
require_relative 'player'
require_relative 'star'

class Game < Gosu::Window #Use a module to prefix the class
  def initialize
    super(640, 480)
    self.caption = "LeWagon Game"

    @player = Player.new
    @background = Gosu::Image.new("media/space.png", tileable: true)

    @star_anim = Gosu::Image.load_tiles("media/star.png", 25, 25)
    @stars = []

    @font = Gosu::Font.new(20)
  end

  def update
    if Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT
      @player.turn_left
    end
    if Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT
      @player.turn_right
    end
    if Gosu.button_down? Gosu::KB_UP or Gosu::button_down? Gosu::GP_BUTTON_0
      @player.accelerate
    end
    @player.move
    @player.collect_stars(@stars)

    if rand(100) < 20 and @stars.size < 100
      puts "Une etoile est nee"
      @stars << Star.new(@star_anim)
    end
  end

  def draw
    @background.draw(0, 0, 0)
    @player.draw
    @stars.each { |star| star.draw }
    @font.draw("Score: #{@player.score}", 10, 10, 0, 1.0, 1.0, Gosu::Color::YELLOW)
  end

end

Game.new.show
