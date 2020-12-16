require_relative '../structure'

class Galaxy < Structure

    STRUCT =[   [1,1,0,1,1,1,1,1,1],
                [1,1,0,1,1,1,1,1,1],
                [1,1,0,0,0,0,0,0,0],
                [1,1,0,0,0,0,0,1,1],
                [1,1,0,0,0,0,0,1,1],
                [1,1,0,0,0,0,0,1,1],
                [0,0,0,0,0,0,0,1,1],
                [1,1,1,1,1,1,0,1,1],
                [1,1,1,1,1,1,0,1,1]
            ]
    NAME = "Galaxy"

    def initialize()
        super STRUCT,NAME
    end
end