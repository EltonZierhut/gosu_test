require 'gosu'

class GameWindow < Gosu::Window
  def initialize(width=800, height=600, fullscreen=false)
    super
    self.caption = 'Hello Movement'
    @x = @y = 10
    @draws = 0
    @button_down = 0
  end

  def update
    @x -= 1 if button_down?(Gosu::KbLeft)
    @x += 1 if button_down?(Gosu::KbRight)
    @y -= 1 if button_down?(Gosu::KbUp)
    @y += 1 if button_down?(Gosu::KbDown)
  end

  def button_down(id)
    close if id == Gosu::KbEscape
    @button_down += 1
  end

  def button_up(id)
    @button_down -= 1
  end

  def draw
    @draws += 1
    @message = Gosu::Image.from_text(
      self, info, Gosu.default_font_name, 30
    )
    @message.draw(@x, @y, 0)
  end

  def info
    "[x:#{@x};y:#{@y};draws:#{@draws};]"
  end

  def needs_redraw?
    return @button_down > 0 || @draws == 0

    false
  end
end

window = GameWindow.new
window.show