require_relative 'tile'

# A piece is basically a collection of tiles that move together
class Piece
  COLORS = {
    pink: Gosu::Color::FUCHSIA,
    cyan: Gosu::Color::CYAN,
    blue: Gosu::Color::BLUE,
    yellow: Gosu::Color::YELLOW,
    red: Gosu::Color::RED,
    green: Gosu::Color::GREEN,
    orange: Gosu::Color.argb(255, 235, 156, 0)
  }.freeze

  INITIAL_CENTER_POSITION = [5, 0].freeze

  attr_reader :center, :tiles, :color

  def initialize(relative_tile_positions)
    @fixed = false

    # all pieces have an initial center tile set at [5, 0]
    @tiles = [Tile.new(INITIAL_CENTER_POSITION.dup, self)]
    relative_tile_positions.each do |rel_pos|
      tile_position = [center_tile[0] + rel_pos[0], center_tile[1] + rel_pos[1]]
      @tiles << Tile.new(tile_position, self)
    end
  end

  def move_down
    return if @fixed

    @tiles.each(&:move_down)
  end

  def move_side(side)
    @tiles.each { |tile| tile.move_side(side) }
  end

  def rotate
    return if @fixed
    @tiles.each { |tile| tile.rotate_around(center_tile.position.dup) }
  end

  def fix!
    @fixed = true
  end

  def fixed?
    @fixed
  end

  def center_tile
    @tiles.first
  end

  def draw
    @tiles.each(&:draw)
  end

  def self.new_random
    # PIECE_CLASSES.sample.new
    # [T, Line, OrangeL, BlueL, Block, RedZ, GreenZ].sample.new
    [T, Line, BlueL].sample.new
  end
end
