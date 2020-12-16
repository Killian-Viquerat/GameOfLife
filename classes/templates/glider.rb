require_relative '../structure'

class Glider < Structure

    STRUCT = [[0,0,1],[1,0,1],[0,1,1]]
    NAME = "Glider"

    def initialize()
        super STRUCT,NAME
    end
end