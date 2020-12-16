require_relative '../structure'

class Point < Structure

    STRUCT = [1]
    NAME = "Point"

    def initialize()
        super STRUCT,NAME
    end
end