class Structure
    
    def initialize(world,struct)
        @world = world
        @struct = struct 
    end

    def create(index_x,index_y)
        @struct.each_with_index do |collumn,x|
            @struct[x].each_with_index do |value,y|
                if(value == 1)
                    @world[index_x+x][index_y+y].color_change?
                end
            end
        end
    end

    def rotate
        newStruct = @struct.clone
        for y in 0...@struct.length
          for x in 0...@struct.length
            p "value: #{@struct[x][y]} columne: #{x} ligne: #{y}"
            newStruct[@struct.length-1-y][x] = @struct[x][y] 
          end
        end
        @struct = newStruct
    end
end