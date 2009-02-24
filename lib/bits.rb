# Bits provides an easy way to store and access sequences of bits, 
# allowing input and output in multiple formats

class Bits

  # +bits+:: The bit field to store
  # +length+:: Length of the bit field - default to calculated length, 0-pad on
  # MSB

  def initialize(bits, length = 0)
    @length = length
    @bits = bit_string_from_input(bits, length)
  end

  def +(bits)
    bit_string_to_concat = bit_string_from_input(bits)
    length = @bits.length + bit_string_to_concat.length
    string = "0b#{@bits}#{bit_string_to_concat}"
    Bits.new(string, length)
  end

  def bit_string
    @bits
  end

  def hex_string
    "%0#{(@bits.length / 4.0).ceil}x" % @bits.to_i(2)
  end

  def oct_string
    "%0#{(@bits.length / 3.0).ceil}o" % @bits.to_i(2)
  end

  def integer
    @bits.to_i(2)
  end

  def set(bits)
    @bits = bit_string_from_input(bits, @length)
  end
  
  protected

  attr_reader :bits

  private

  def bit_string_from_input(bits, length = 0)
    case bits
    when Integer, Fixnum, Bignum
      "%0#{length}b" % bits
    when String
      "%0#{length}b" % Integer(bits)
    when Bits
      bits.bits
    when BitFields
      bits.get_bits.bits
    else
      warn "Unsupported data #{bits} (#{bits.class}) - defaulting to #{length} length zero field"
      "%0#{length}b" % 0
    end
  end
end
