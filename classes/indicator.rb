
class Indicator 
    attr_accessor :position
    def initialize(cellsize)
        @position = Vector.new(0,0)
        @color = Gosu::Color.rgba(148, 140, 245, 255)
        @cellsize = cellsize
    end

    def draw
        Gosu.draw_rect(@position.x,@position.y,1,@cellsize,@color)
        Gosu.draw_rect(@position.x,@position.y,@cellsize,1,@color)
        Gosu.draw_rect(@position.x,@position.y+@cellsize-1,@cellsize,1,@color)
        Gosu.draw_rect(@position.x+@cellsize-1,@position.y,1,@cellsize,@color)
    end
end