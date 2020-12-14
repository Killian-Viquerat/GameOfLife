require_relative 'structure'

class Glider < Structure

    STRUCT = [[0,0,1],[1,0,1],[0,1,1]]

    def initialize(world)
        super world, STRUCT
    end
end