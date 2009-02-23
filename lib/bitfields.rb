require File.dirname(__FILE__) + '/bits'

class BitFields
  
  # Class methods
  
  def self.template(template_name, &block)
    template_name = symbol_if_string(template_name)
    templates[template_name] = block
    nil
  end
 
  def self.create(template_name, params = {})
    template_name = symbol_if_string(template_name)
    if templates[template_name]
      instance = self.new
      templates[template_name].call(instance)
      params.each_pair { | field_name, value | instance[field_name] = value }
      instance
    else
      warn "BitFields: No template named #{template_name}"
      nil
    end
  end

  def self.decode(template_name, value)
    template_name = symbol_if_string(template_name)
    if templates[template_name]
      instance = self.new
      templates[template_name].call(instance)
      bit_string = Bits.new(value, instance.total_length).bit_string
      current_index = 0
      instance.field_names.each_with_index do |field_name, index|
        length = instance.field_lengths[index]
        instance[field_name] = bit_string[current_index, length].to_i(2)
        current_index += length
      end
      instance
    else
      warn "BitFields: No template named #{template_name}"
      nil
    end
  end

  def self.compose(&block)
    composition = self.new
    yield composition
    composition
  end

  # Object methods
  
  def integer; get_bits.integer end
  def bit_string; get_bits.bit_string end
  def hex_string; get_bits.hex_string end
  def oct_string; get_bits.oct_string end

  def total_length
    field_lengths.inject { |total, length| total + length }
  end

  def add(field_name, instance)
    field_name = BitFields.symbol_if_string(field_name)
    if instance
      field_names << field_name
      field_values << instance.get_bits
    end
  end

  def bring(template_name, params = {})
    template_name = BitFields.symbol_if_string(template_name)
    instance = BitFields.create(template_name, params)
    if instance
      field_names << template_name
      field_values << instance.get_bits
    end
  end

  def bits(field_name, params = {})
    field_name = BitFields.symbol_if_string(field_name)
    value = params.key?(:value) ? params[:value] : 0
    length = params.key?(:length) ? params[:length] : 0
    field_names << field_name
    field_values << Bits.new(value, length)
    field_lengths << length
  end

  def get_bits
    field_values.inject(nil) do |final, value|
      final ? final + value : value
    end
  end

  def [](field_name)
    field_name = BitFields.symbol_if_string(field_name)
    field_values[field_names.index(field_name)] if field_names.index(field_name)
  end

  def []=(field_name, value)
    self[field_name].set(value) if self[field_name]
  end

  def field_names
    @field_names ||= Array.new
  end

  def field_values
    @field_values ||= Array.new
  end

  def field_lengths
    @field_lengths ||= Array.new
  end

  private

  def self.templates
    @@templates ||= Hash.new
  end

  # Helpers

  def self.symbol_if_string(name)
    name.kind_of?(String) ? name.to_sym : name
  end
end

