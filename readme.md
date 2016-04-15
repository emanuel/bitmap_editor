## Basic interactive bitmap editor

### Definition

1.1) Commands

The input consists of a string containing a sequence of commands, where a command is represented by a single capital letter at the beginning of the line.

1.2) Commands Parameters

Parameters of the command are separated by white spaces and they follow the command character.

1.3) Pixels

Pixel co-ordinates are a pair of integers:
- a column number between 1 and 250
- and a row number between 1 and 250

1.4) Bitmaps

- Bitmaps starts at coordinates 1,1
- Colours are specified by capital letters.

1.5) There are 8 supported commands:

- **I M N** - Create a new M x N image with all pixels coloured white (O).
- **C** - Clears the table, setting all pixels to white (O).
- **L X Y C** - Colours the pixel (X,Y) with colour C.
- **V X Y1 Y2 C** - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
- **H X1 X2 Y C** - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
- **S** - Show the contents of the current image
- **?** - Displays help text
- **X** - Terminate the session

### Setting up

2.1) To run the tests there is a dependency on RSpec so please do:

``` bash
  bundle install
```

2.2) Start the REPL with:

``` bash
  ruby runner.rb
```

2.3) Run the specs with:

``` bash
  rspec spec
```
