require_relative 'piece'

class T < Piece
  def initialize
    @color = :pink
    relative_tile_positions = [
      [0, -1],
      [0, 1],
      [1, 0]
    ]
    super(relative_tile_positions)
  end
end

class Line < Piece
  def initialize
    @color = :cyan
    relative_tile_positions = [
      [-1, 0],
      [1, 0],
      [2, 0]
    ]
    super(relative_tile_positions)
  end
end

class BlueL < Piece
  def initialize
    @color = :blue
    relative_tile_positions = [
      [0, -1],
      [1, 0],
      [2, 0]
    ]
    super(relative_tile_positions)
  end
end

class OrangeL < Piece
  def initialize
    super
    @color = :orange
    relative_tile_positions = [
      [0, 1],
      [1, 0],
      [2, 0]
    ]
  end
end

class RedZ < Piece
  def initialize
    super
    @color = :red
    @tiles = [
      [0, 0],
      [-1, 0],
      [0, 1],
      [1, 1]
    ]
  end
end

class GreenZ < Piece
  def initialize
    super
    @color = :green
    @tiles = [
      [0, 0],
      [1, 0],
      [0, 1],
      [-1, 1]
    ]
  end
end

class Block < Piece
  def initialize
    super
    @color = :yellow
    @tiles = [
      [0, 0],
      [0, 1],
      [1, 0],
      [1, 1]
    ]
  end
end
