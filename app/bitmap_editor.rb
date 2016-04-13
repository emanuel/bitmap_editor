# Main Module of the BitmapEditor
module BitmapEditor
  # HELP TEXT is constant and freezed in memory for quick access
  HELP_TEXT <<~EOS
    ? - Help
    I M N - Create a new M x N image with all pixels coloured white (O).
    C - Clears the table, setting all pixels to white (O).
    L X Y C - Colours the pixel (X,Y) with colour C.
    V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
    H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
    S - Show the contents of the current image
    X - Terminate the session
  EOS

  def self.run
    @running = true
    puts 'type ? for help'
    while @running
      print '> '
      handle_input(gets.chomp)
    end
  end

  private

  def self.handle_input(input)
    case input
    when '?'
      puts HELP_TEXT
    when 'X'
      exit_console
    else
      puts 'unrecognised command :('
    end
  end

  def self.exit_console
    puts 'Goodbye!'
    @running = false
  end

end
