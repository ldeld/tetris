require 'gosu'
require_relative 'pieces'


NUMBER_OF_LINES = 20
NUMBER_OF_COLUMNS = 10
WINDOW_WIDTH = NUMBER_OF_COLUMNS * Tile::TILE_SIZE
WINDOW_HEIGHT = NUMBER_OF_LINES * Tile::TILE_SIZE
INITIAL_INTERVAL = 200

class Game < Gosu::Window
  def initialize
    @score = 0
    @set_tiles = []
    @active_piece = Piece.new_random
    super(WINDOW_WIDTH, WINDOW_HEIGHT, update_interval: INITIAL_INTERVAL)
  end

  def move_active_piece
    if button_down?(Gosu::KB_LEFT)
      @active_piece.move_side(:left)
    elsif button_down?(Gosu::KB_RIGHT)
      @active_piece.move_side(:right)
    end

    @active_piece.move_down
  end

  def update
    move_active_piece
    @active_piece.rotate if button_down?(Gosu::KB_UP)
    if piece_touched_bottom?
      @active_piece.fix!
      @set_tiles += @active_piece.tiles
      check_for_full_lines
      @active_piece = Piece.new_random
    end
  end

  def draw
    @set_tiles.each(&:draw)
    @active_piece.draw
  end

  def piece_touched_bottom?
    @active_piece.tiles.each do |tile|
      return true if tile[1] >= NUMBER_OF_LINES - 1
      return true if @set_tiles.any? do |set_tile|
        set_tile[0] == tile[0] && set_tile[1] == tile[1] + 1
      end
    end

    false
  end

  def check_for_full_lines
    (1..NUMBER_OF_LINES - 1).each do |line_number|
      tiles_in_line = @set_tiles.select { |tile| tile[1] == line_number }
      if tiles_in_line.length == NUMBER_OF_COLUMNS
        @set_tiles -= tiles_in_line
        @set_tiles.each { |tile| tile.move_down if tile[1] <= line_number }
      end
    end
  end

  def button_down?(id)
    id == Gosu::KB_ESCAPE ? close : super(id)
  end
end

Game.new.show
