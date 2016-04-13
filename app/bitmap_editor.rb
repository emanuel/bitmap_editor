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

  # responsible for runing the REPL
  module REPL
    module_function

    def run
      @running = true
      puts BitmapEditor::REPL_MSG
      while @running
        print '> '
        Parser.parse(gets.chomp)
      end
    end

    def exit
      @running = false
    end
  end

  # responsible for parsing the REPL comands
  module Parser
    module_function

    def parse(input)
      case input
      when '?'
        puts HELP_TEXT
      when 'X'
        puts GOODBYE_MSG
        REPL.exit
      else
        puts 'unrecognised command :('
      end
    end
  end
end
