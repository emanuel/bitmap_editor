# Main Module of the BitmapEditor
module BitmapEditor
  # constants text messages

  HELP_TEXT = <<~EOS
    ? - Help
    I M N - Create a new M x N image with all pixels coloured white (O)
    C - Clears the table, setting all pixels to white (O)
    L X Y C - Colours the pixel (X,Y) with colour C
    V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive)
    H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive)
    S - Show the contents of the current image
    X - Terminate the session
  EOS

  GOODBYE_MSG = 'Goodbye!'
  REPL_MSG = 'type ? for help'
  ERROR_MSG = 'unrecognised command :('

  PIXEL_LIMITS = 250

  attr_accessor :image

  # responsible for runing the REPL
  module REPL
    module_function

    def run
      @running = true
      puts BitmapEditor::REPL_MSG
      while @running
        print '> '
        result = Parser.parse(gets.chomp)
        # input was parsed correctly then call its associated method
        # with already validated params
        result[:ok] ? send(result[:command], *result[:params]) : puts(ERROR_MSG)
      end
    end

    def exit
      @running = false
    end

    def show_help(_params = {})
      puts HELP_TEXT
    end

    #
    # Commands
    #

    # Create image command
    def create_image(m,n)
      @image = Image.new m.to_i, n.to_i
    end

    # Image clear
    def clear_table(_params = {})
      @image.clear!
    end

    # colorize pixel #L X Y C
    def colours_pixel(x, y, colour)
      pixel = Image::Pixel.new x.to_i, y.to_i
      @image.colorize pixel, colour
    end

    # draw a vertical segment
    def draw_vertical_segment(x, y1, y2, colour)
      @image.draw_vertical x.to_i, y1.to_i, y2.to_i, colour
    end

    # draw a vertical segment #H X1 X2 Y C
    def draw_horizontal_segment(x1, x2, y, colour)
      @image.draw_horizontal y.to_i, x1.to_i, x2.to_i, colour
    end

    # show contents
    def show_contents_image
      puts @image.show if @image
    end
  end

end
