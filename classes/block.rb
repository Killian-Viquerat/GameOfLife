class Block

    HEIGTH = 10
    WIDTH = 10

    def initialize(vector,x,y)
        @position = vector
        @color = Gosu::Color.rgba(0, 0, 0, 255)
        @x = x
        @y = y
        @on = false
    end

    def draw
        Gosu.draw_rect(@position.x,@position.y,HEIGTH,WIDTH,@color)
    end

    def color_change?
        if(@on)
            @color = Gosu::Color.rgba(0, 0, 0, 255)
            @on = false
        else
            @color = Gosu::Color.rgba(@x, @y, 255, 255)
            @on = true
        end
    end

    def on?
        @on ? 1 : 0
    end
end