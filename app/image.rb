module BitmapEditor
  # Define some sample colours
  class Colour
    # some sample colors definitions
    WHITE = 0
    BLACK = 'B'
    RED = 'R'
  end

  # class that deals with the internal implementation of the BitMap
  class Image
    # Pixel definition
    Pixel = Struct.new(:x, :y)

    # accessors
    attr_reader :width, :heigth, :data

    def initialize(width, height)
      @width = width
      @height = height
      @data = Array.new(height) { Array.new(width, Colour::WHITE) }
    end

    # string representation of the image
    def show
      @data.map{ |line| line.join }
    end

    # colorize one pixel
    def colorize(pixel, colour)
      validate_pixel(pixel)
      pos_x, pos_y = (pixel.x - 1), (pixel.y - 1)
      @data[pos_y][pos_x] = colour
    end

    # drawing a vertical line : colx, row_y1, row_y2, colour
    def draw_vertical(col_x, row_y1, row_y2, colour)
      list_of_pixels = (row_y1..row_y2).map { |p| Pixel.new(col_x,p) }
      draw_line_of_pixels list_of_pixels, colour
    end

    # drawing an horizontal line : rowy, col_x1, col_x2, colour
    def draw_horizontal(row_y, col_x1, col_x2, colour)
      list_of_pixels = (col_x1..col_x2).map { |p| Pixel.new(p,row_y) }
      draw_line_of_pixels list_of_pixels, colour
    end

    # draws a line between two pixels p1 and p2
    def draw_line(p1, p2, colour)
      if p1.y == p2.y
        draw_horizontal p1.y, p1.x, p2.x, colour
      else
        draw_vertical p1.x, p1.y, p2.y, colour
      end
    end

    # fills the Matrix with White
    def clear!
      fill Colour::WHITE
    end

    protected

    # auxiliary methods

    def fill(colour)
      @data = Array.new(@height) { Array.new(@width, colour) }
    end

    def validate_pixel(pixel)
      unless pixel.is_a?(Struct) && is_valid?(pixel)
        fail ArgumentError, "pixel (#{pixel}) is outside the dimensions of this image"
      end
    end

    def is_valid? pixel
      pixel.x.between?(1, @width) && pixel.y.between?(1, @height)
    end

    # colorize a line of pixels
    def draw_line_of_pixels(list_of_pixels, colour)
      list_of_pixels.each { |pixel| colorize(pixel,colour) }
    end
  end
end