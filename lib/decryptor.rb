require_relative 'wheel_generator'
class Decryptor
  attr_reader :message, :new_key
  CHAR_MAP = ["a", "b", "c", "d",
              "e", "f", "g", "h",
              "i", "j", "k", "l",
              "m", "n", "o", "p",
              "q", "r", "s", "t",
              "u", "v", "w", "x",
              "y", "z", "0", "1",
              "2", "3", "4", "5",
              "6", "7", "8", "9",
              " ", ".", ","]

  def initialize(message, key, date)
    @message = message.chars
    @new_key = WheelGenerator.new(12345, 161215)
    @date = date
  end

  def message_value
    message_value = message.map do |character|
      CHAR_MAP.index(character)
    end
  end

  def slice_message
    sliced_message  = []
    message_value.each_slice(4) do |character|
      sliced_message << character
    end
    sliced_message
  end

  def rotate_message
    rotated_message = []
    slice_message.each do |array|
      array.each.with_index do |character, index|
        rotation = if index == 0
          @new_key.final_rotation_a
        elsif index == 1
          @new_key.final_rotation_b
        elsif index == 2
          @new_key.final_rotation_c
        elsif index == 3
          @new_key.final_rotation_d
        end
        rotated_message << (character - rotation) % 39
      end
    end
    rotated_message
  end

  def decrypt_message
    decrypt_message = rotate_message.map do |character|
      CHAR_MAP[character]
    end
    decrypt_message.join
  end

end
