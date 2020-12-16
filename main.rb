require 'gosu'
require_relative 'classes/block'
require_relative 'classes/vector'
require_relative 'classes/indicator'
require_relative 'classes/templates/point'
require_relative 'classes/templates/glider'
require_relative 'classes/templates/pulsar'
require_relative 'classes/templates/puffertrain'
require_relative 'classes/templates/galaxy'


class Game < Gosu::Window

    DIVIDER = 8
    KIND_MAP = [Point,Glider,Pulsar,PufferTrain,Galaxy]

    def initialize
        super 1920, 1080
        self.caption = "Game of Life"
        @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
        @ligne = Gosu.screen_width/DIVIDER
        @collumn = Gosu.screen_height/DIVIDER 
        @world = Array.new(@ligne) {Array.new(@collumn)}
        @indicator = Indicator.new(DIVIDER)
        @start = false
        @generation = 0
        @index = 0
        @object = nil
        create()
    end

    def create
        @world.each_with_index do |value,index_x|
            @world[index_x].each_with_index do |value,index_y|
                @world[index_x][index_y] = Block.new(Vector.new(index_x*DIVIDER,index_y*DIVIDER),index_x,index_y)
            end
        end
    end

    def update_world()
        newWorld = Array.new(@ligne) {Array.new(@collumn)}
        @world.each_with_index do |value,index_x|
            @world[index_x].each_with_index do |value,index_y|
                number = 0
                newblock = value.clone
                if(index_y-1 >= 0)
                    number += @world[index_x][index_y-1].on?
                end
                if(index_x+1<=@ligne-1 && index_y-1>=0)
                    number += @world[index_x+1][index_y-1].on?
                end
                if(index_x+1<=@ligne-1)
                    number += @world[index_x+1][index_y].on?
                end
                if(index_x+1<=@ligne-1 && index_y+1<=@collumn-1)
                    number += @world[index_x+1][index_y+1].on?
                end
                if(index_y+1<=@collumn-1)
                    number += @world[index_x][index_y+1].on?
                end
                if(index_x>=0 && index_y+1 <= @collumn-1)
                    number += @world[index_x-1][index_y+1].on?
                end
                if(index_x-1>=0)
                    number += @world[index_x-1][index_y].on?
                end
                if(index_x-1>=0 && index_y-1>=0)
                    number += @world[index_x-1][index_y-1].on?
                end
                if(@world[index_x][index_y].on? == 1)
                    if(number <= 1)
                        newblock.color_change?
                        newWorld[index_x][index_y]= newblock
                    elsif(number >=2 && number <=3)
                        newWorld[index_x][index_y]=newblock
                    elsif(number > 3)
                        newblock.color_change?
                        newWorld[index_x][index_y]=newblock
                    end
                else
                    if(number == 3)
                        newblock.color_change?
                        newWorld[index_x][index_y]=newblock
                    else
                        newWorld[index_x][index_y]=newblock
                    end
                end
            end
        end
        return newWorld
    end

    def update
        @indicator.position = Vector.new((self.mouse_x/DIVIDER).floor*DIVIDER,(self.mouse_y/DIVIDER).floor*DIVIDER)
        if(@start)
            @world = update_world()
            @generation += 1
        end
    end

    def draw
        @world.each do |lignes|
            lignes.each do |block|
                block.draw
            end
        end
        @indicator.draw
        @font.draw_text(@generation,self.width-30,self.height-30,0,1,1,Gosu::Color.rgba(255, 255, 255, 255))
        if(@object != nil)
            @font.draw_text(@object.name,30,self.height-30,0,1,1,Gosu::Color.rgba(255, 255, 255, 255))
        else
            @font.draw_text(KIND_MAP[@index],30,self.height-30,0,1,1,Gosu::Color.rgba(255, 255, 255, 255))
        end
    end

    def button_down(button)
        case button
        when Gosu::KB_RIGHT
            if(@index < KIND_MAP.length-1)
                @index += 1 
            else
                @index = 0
            end
            @object = KIND_MAP[@index].new
        when Gosu::KB_LEFT
            if(@index == 0)
                @index = KIND_MAP.length-1
            else
                @index -= 1
            end
            @object = KIND_MAP[@index].new
        when Gosu::MsLeft
            if(@object.nil?)
                @object = KIND_MAP[@index].new
            end
            @object.create(@world,@indicator.position.x/DIVIDER,@indicator.position.y/DIVIDER)
        when Gosu::KB_SPACE 
            @start ? @start = false : @start = true
        when Gosu::KB_R
            if(@object != nil)
                @object.rotate
            end
        end
    end
end


game = Game.new.show