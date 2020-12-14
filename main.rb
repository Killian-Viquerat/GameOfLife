require 'gosu'
require_relative 'classes/block'
require_relative 'classes/vector'
require_relative 'classes/indicator'
require_relative 'classes/glider'


class Game < Gosu::Window

    DIVIDER = 10
    KIND_MAP = ["Point",Glider]

    def initialize
        super 1920, 1080
        self.caption = "Maze Generator"
        @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
        @ligne = Gosu.screen_width/DIVIDER
        @collumn = Gosu.screen_height/DIVIDER 
        @world = Array.new(@ligne) {Array.new(@collumn)}
        @indicator = Indicator.new()
        @start = false
        @generation = 0
        @index = 0
        @object = nil
        create()
    end

    def create
        @world.each_with_index do |value,index_x|
            @world[index_x].each_with_index do |value,index_y|
                @world[index_x][index_y] = Block.new(Vector.new(index_x*10,index_y*10),index_x,index_y)
            end
        end
    end

    def update
        @indicator.position = Vector.new((self.mouse_x/10).floor*10,(self.mouse_y/10).floor*10)
        if(@start)
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
            @generation += 1
            @world = newWorld
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
    end

    def button_down(button)
        case button
        when Gosu::KB_RIGHT
            if(@index < KIND_MAP.length-1)
                @index += 1 
            else
                @index = 0
            end
        when Gosu::MsLeft
            if(KIND_MAP[@index] == "Point")
                @object = nil
                @world[@indicator.position.x/10][@indicator.position.y/10].color_change?
            else
                @object = KIND_MAP[@index].new(@world)
                @object.create(@indicator.position.x/10,@indicator.position.y/10)
            end
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