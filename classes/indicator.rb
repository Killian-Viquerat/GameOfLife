
class Indicator 
    attr_accessor :position
    def initialize
        @position = Vector.new(0,0)
        @color = Gosu::Color.rgba(148, 140, 245, 255)
    end

    def draw
        Gosu.draw_rect(@position.x,@position.y,1,10,@color)
        Gosu.draw_rect(@position.x,@position.y,10,1,@color)
        Gosu.draw_rect(@position.x,@position.y+9,10,1,@color)
        Gosu.draw_rect(@position.x+9,@position.y,1,10,@color)
    end
end