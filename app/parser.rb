module BitmapEditor
  # Parser Module
  # responsible for parsing the commands
  #
  module Parser
    # Hash of valid commands known by the parser with their definition
    # method name | number of numeric params | number of color params

    COMMAND_LIST = { 'I' => [:create_image,            2, 0],
                     'C' => [:clear_table,             0, 0],
                     'L' => [:colours_pixel,           2, 1],
                     'V' => [:draw_vertical_segment,   3, 1],
                     'H' => [:draw_horizontal_segment, 3, 1],
                     'S' => [:show_contents_image,     0, 0],
                     '?' => [:show_help,               0, 0],
                     'X' => [:exit,                    0, 0] }

    module_function

    def parse(input)
      # process if the first char of the input is a known command otherwise return error
      COMMAND_LIST[input[0]] ? parse_command(input) : { ok: false }
    end

    def parse_command(input)
      params = input.split
      command = params.shift
      numeric_params = COMMAND_LIST.dig(command, 1)
      color_params = COMMAND_LIST.dig(command, 2)
      total_number_params = numeric_params + color_params
      return { ok: false } if params.size != total_number_params
      return { ok: false } if params[0..numeric_params - 1].any? do |p|
        p.to_i > PIXEL_LIMITS || p.to_i < 1
      end
      # return the correct method_name and validated params
      { ok: true, command: COMMAND_LIST.dig(command, 0), params: params }
    end
  end
end
