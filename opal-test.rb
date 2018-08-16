class Jewelry
  def initialize(grade, clarity, color)
    @grade = grade
    @clarity = clarity
    @color = color
  end

  def price
    case @grade
    when 'A+'
      base_price
    when 'A'
      0.9 * base_price
    when 'B'
      0.8 * base_price
    when 'C'
      0.7 * base_price
    else
      0.6 * base_price
    end
  end

  private

  def base_price
    @clarity + @color
  end
end

class Ruby < Jewelry
  def initialize(grade, clarity, color)
    super(grade, clarity, color)
  end
end

rb = Ruby.new('A', 10, 10)
puts rb.price
