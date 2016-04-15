describe BitmapEditor::Parser do
  describe '.parse' do
    context 'given a valid input' do
      it 'returns a method name and valid params' do
        expect(BitmapEditor::Parser.parse('I 1 1'))
          .to include(ok: true, command: :create_image, params: %w(1 1))

        expect(BitmapEditor::Parser.parse('C'))
          .to include(ok: true, command: :clear_table, params: [])

        expect(BitmapEditor::Parser.parse('L 250 250 A'))
          .to include(ok: true, command: :colours_pixel, params: %w(250 250 A))

        expect(BitmapEditor::Parser.parse('V 50 1 10 C'))
          .to include(ok: true, command: :draw_vertical_segment, params: %w(50 1 10 C))

        expect(BitmapEditor::Parser.parse('H 50 1 10 Z'))
          .to include(ok: true, command: :draw_horizontal_segment, params: %w(50 1 10 Z))

        expect(BitmapEditor::Parser.parse('S'))
          .to include(ok: true, command: :show_contents_image, params: [])

        expect(BitmapEditor::Parser.parse('?'))
          .to include(ok: true, command: :show_help, params: [])

        expect(BitmapEditor::Parser.parse('X'))
          .to include(ok: true, command: :exit, params: [])
      end
    end
    context 'given an invalid input' do
      it 'parses input and retunrs error message' do
        expect(BitmapEditor::Parser.parse('I 256 1000')).to include(ok: false)
        expect(BitmapEditor::Parser.parse('C 1 1 ')).to include(ok: false)
        expect(BitmapEditor::Parser.parse('L 255 255')).to include(ok: false)
        expect(BitmapEditor::Parser.parse('V 50 1 10 C C')).to include(ok: false)
        expect(BitmapEditor::Parser.parse('H 50 Z 20 Z')).to include(ok: false)
        expect(BitmapEditor::Parser.parse('S 1')).to include(ok: false)
        expect(BitmapEditor::Parser.parse('? 1')).to include(ok: false)
        expect(BitmapEditor::Parser.parse('X 1')).to include(ok: false)
      end
    end
  end
end