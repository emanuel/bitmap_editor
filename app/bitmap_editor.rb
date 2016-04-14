require 'pry'
# Main Module of the BitmapEditor
module BitmapEditor
  # constants text messages
  HELP_TEXT = <<~EOS
    ? - Help
    I M N - Create a new M x N image with all pixels coloured white (O).
    C - Clears the table, setting all pixels to white (O).
    L X Y C - Colours the pixel (X,Y) with colour C.
    V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
    H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
    S - Show the contents of the current image
    X - Terminate the session
  EOS

  GOODBYE_MSG = 'Goodbye!'
  REPL_MSG = 'type ? for help'
  ERROR_MSG = 'unrecognised command :('

  PIXEL_LIMITS = 250

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
  end


  # Parser Module
  # responsible for parsing the commands
  #
  module Parser
    # Hash of valid commands known by the parser
    # with a method name and number of possible params

    COMMAND_LIST = { 'I' => [:create_image,            2],
                     'C' => [:clear_the_table,         0],
                     'L' => [:colours_the_pixel,       3],
                     'V' => [:draw_vertical_segment,   4],
                     'H' => [:draw_horizontal_segment, 4],
                     'S' => [:show_contents_image,     0],
                     '?' => [:show_help,               0],
                     'X' => [:exit,                    0] }

    module_function

    def parse(input)
      # if the first char of the input is a know command we process
      # if not the parser returns an error
      COMMAND_LIST[input[0]] ? process_command!(input) : { ok: false }
    end

    def process_command!(input)
      params = input.split
      command = params.shift
      exact_number_of_supported_params = COMMAND_LIST.dig(command, 1)

      return { ok: false } if params.size != exact_number_of_supported_params
      return { ok: false } if params.any? { |p| p.to_i > PIXEL_LIMITS }

      # return the correct method_name and validated params
      { ok: true, command: COMMAND_LIST.dig(command, 0), params: params }
    end
  end

end
