describe BitmapEditor::Image do
  describe '#new' do
    it 'creates a new image bitmap' do
      image = BitmapEditor::Image.new(5, 6)
      expect(image.data).to eq([[0, 0, 0, 0, 0],
                                [0, 0, 0, 0, 0],
                                [0, 0, 0, 0, 0],
                                [0, 0, 0, 0, 0],
                                [0, 0, 0, 0, 0],
                                [0, 0, 0, 0, 0]])
    end
  end

  describe '#show' do
    it 'outputs the contents of the image' do
      image = BitmapEditor::Image.new(3, 3)
      expect(image.show).to eq(%w(000 000 000))
    end
  end

  describe '#colorize' do
    it 'colorizes a pixel on the bitmap' do
      image1 = BitmapEditor::Image.new(2, 3)
      pixel = BitmapEditor::Image::Pixel.new(1, 1)
      c = BitmapEditor::Colour::BLACK

      image1.colorize pixel, c
      expect(image1.data).to eq([[c, 0],
                                 [0, 0],
                                 [0, 0]])

      image2 = BitmapEditor::Image.new(2, 3)
      pixel =  BitmapEditor::Image::Pixel.new(2, 3)
      c = BitmapEditor::Colour::RED

      image2.colorize pixel, c
      expect(image2.data).to eq([[0, 0],
                                 [0, 0],
                                 [0, c]])
    end
  end

  describe '#draw_vertical' do
    it 'draws a vertical line of pixels on the x column' do
      image = BitmapEditor::Image.new(4, 4)
      c = BitmapEditor::Colour::BLACK
      image.draw_vertical 2, 2, 4, c # colx, row_y1, row_y2, color
      expect(image.data).to eq([[0, 0, 0, 0],
                                [0, c, 0, 0],
                                [0, c, 0, 0],
                                [0, c, 0, 0]])
    end
  end

  describe '#draw_horizontal' do
    it 'draws an horizontal line of pixels on the y line' do
      image = BitmapEditor::Image.new(4, 4)
      c = BitmapEditor::Colour::BLACK
      image.draw_horizontal 2, 2, 4, c # row_y, col_x1, col_x2, colour
      expect(image.data).to eq([[0, 0, 0, 0],
                                [0, c, c, c],
                                [0, 0, 0, 0],
                                [0, 0, 0, 0]])
    end
  end
end
