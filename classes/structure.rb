class Structure
    attr_accessor :name
    def initialize(struct,name)
        @struct = struct 
        @name = name
    end

    def create(world,index_x,index_y)
        @struct.each_with_index do |collumn,x|
            if(@struct[x].is_a?(Array))
                @struct[x].each_with_index do |value,y|
                    if(value == 1)
                        world[index_x+x][index_y+y].color_change?
                    end
                end
            else
                world[index_x][index_y].color_change?
            end
        end
    end

    def rotate
        newStruct = @struct.clone
        @struct = newStruct.transpose.map(&:reverse)
    end
end