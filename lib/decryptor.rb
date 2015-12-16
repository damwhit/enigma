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

  def initialize(message, key)
    @message = message.chars
    @new_key = key #WheelGenerator.new(12345, 131215)  # => #<WheelGenerator:0x007fa000931410 @key="12345", @date=131215, @key_rotation_a=12, @key_rotation_b=23, @key_rotation_c=34, @key_rotation_d=45>
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
# 
# #
# new_decryptor = Decryptor.new("hello", 12345)  # => #<Decryptor:0x007f8c209519c0 @message=["h", "e", "l", "l", "o"], @new_key=12345>
# new_decryptor.message_value                    # => [7, 4, 11, 11, 14]
# new_decryptor.slice_message                    # => [[7, 4, 11, 11], [14]]
# new_decryptor.rotate_message
# new_decryptor.encrypt_message

# # ~> NoMethodError
