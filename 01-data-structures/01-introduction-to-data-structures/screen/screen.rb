require_relative 'pixel'

class Screen
  attr_accessor :width
  attr_accessor :height
  attr_accessor :matrix

  def initialize(width, height)
    @width = width
    @height = height
    @matrix = Array.new(width) { Array.new(height) }
  end

  # Insert a Pixel at x, y
  def insert(pixel, x, y)
    # Insert the pixel only if the coordinate is valid
    @matrix[x][y] = pixel if inbounds(x, y)
  end

  def at(x, y)
    # If given an invalid coordinate, return nil
    inbounds(x, y) ? @matrix[x][y] : nil
  end

  private

  def inbounds(x, y)
    # Validate given coordinates
    (x > 0 && x <= self.width) && (y > 0 && y <= self.height)
  end

end