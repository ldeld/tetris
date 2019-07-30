require 'pry'
class Tile
  TILE_SIZE = 40

  attr_reader :position

  def initialize(position, piece)
    @position = position
    @piece = piece
  end

  def move_down
    @position[1] += 1
  end

  def move_side(side)
    dir = side == :left ? -1 : 1
    @position[0] += dir
  end

  def rotate_around(rotation_center)
    # binding.pry
    @position[0] -= rotation_center[0]
    @position[1] -= rotation_center[1]

    new_relative_x = -@position[1]
    new_relative_y = @position[0]

    @position[0] = new_relative_x + rotation_center[0]
    @position[1] = new_relative_y + rotation_center[1]
  end

  def draw
    draw_outer_rect
    draw_inner_color
  end

  def [](index)
    @position[index]
  end

  private

  def draw_outer_rect
    Gosu.draw_rect(
      (@position[0]) * TILE_SIZE,
      (@position[1]) * TILE_SIZE,
      TILE_SIZE,
      TILE_SIZE,
      Gosu::Color::WHITE
    )
  end

  def draw_inner_color
    inner_size = TILE_SIZE * 0.9
    margin_offset = TILE_SIZE * 0.05

    Gosu.draw_rect(
      @position[0] * TILE_SIZE + margin_offset,
      @position[1] * TILE_SIZE + margin_offset,
      inner_size,
      inner_size,
      Piece::COLORS[@piece.color]
    )
  end
end
