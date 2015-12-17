require_relative 'wheel_generator'  # => true
class Encryptor
  attr_reader :message, :new_key    # => nil
  CHAR_MAP = ["a", "b", "c", "d",   # => "d"
              "e", "f", "g", "h",   # => "h"
              "i", "j", "k", "l",   # => "l"
              "m", "n", "o", "p",   # => "p"
              "q", "r", "s", "t",   # => "t"
              "u", "v", "w", "x",   # => "x"
              "y", "z", "0", "1",   # => "1"
              "2", "3", "4", "5",   # => "5"
              "6", "7", "8", "9",   # => "9"
              " ", ".", ","]        # => ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", " ", ".", ","]

  def initialize(message, key, date)
    @message = message.chars                      # => ["h", "e", "l", "l", "o"]
    @new_key = WheelGenerator.new(12345, 161215)  # => #<WheelGenerator:0x007fe14d841508 @key="12345", @date=161215, @key_rotation_a=12, @key_rotation_b=23, @key_rotation_c=34, @key_rotation_d=45>
    @date = date                                  # => 161215
  end

  def message_value
    message_value = message.map do |character|  # => ["h", "e", "l", "l", "o"], ["h", "e", "l", "l", "o"], ["h", "e", "l", "l", "o"], ["h", "e", "l", "l", "o"]
      CHAR_MAP.index(character)                 # => 7, 4, 11, 11, 14, 7, 4, 11, 11, 14, 7, 4, 11, 11, 14, 7, 4, 11, 11, 14
    end                                         # => [7, 4, 11, 11, 14], [7, 4, 11, 11, 14], [7, 4, 11, 11, 14], [7, 4, 11, 11, 14]
  end

  def slice_message
    sliced_message  = []                        # => [], [], []
    message_value.each_slice(4) do |character|  # => [7, 4, 11, 11, 14], [7, 4, 11, 11, 14], [7, 4, 11, 11, 14]
      sliced_message << character               # => [[7, 4, 11, 11]], [[7, 4, 11, 11], [14]], [[7, 4, 11, 11]], [[7, 4, 11, 11], [14]], [[7, 4, 11, 11]], [[7, 4, 11, 11], [14]]
    end                                         # => nil, nil, nil
    sliced_message                              # => [[7, 4, 11, 11], [14]], [[7, 4, 11, 11], [14]], [[7, 4, 11, 11], [14]]
  end

  def rotate_message
    rotated_message = []                                # => [], []
    slice_message.each do |array|                       # => [[7, 4, 11, 11], [14]], [[7, 4, 11, 11], [14]]
      array.each.with_index do |character, index|       # => #<Enumerator: [7, 4, 11, 11]:each>, #<Enumerator: [14]:each>, #<Enumerator: [7, 4, 11, 11]:each>, #<Enumerator: [14]:each>
        rotation = if index == 0                        # => true, false, false, false, true, true, false, false, false, true
          new_key.final_rotation_a                      # => 18, 18, 18, 18
        elsif index == 1                                # => true, false, false, true, false, false
          new_key.final_rotation_b                      # => 25, 25
        elsif index == 2                                # => true, false, true, false
          new_key.final_rotation_c                      # => 36, 36
        elsif index == 3                                # => true, true
          new_key.final_rotation_d                      # => 50, 50
        end                                             # => 18, 25, 36, 50, 18, 18, 25, 36, 50, 18
        rotated_message << (rotation + character) % 39  # => [25], [25, 29], [25, 29, 8], [25, 29, 8, 22], [25, 29, 8, 22, 32], [25], [25, 29], [25, 29, 8], [25, 29, 8, 22], [25, 29, 8, 22, 32]
      end                                               # => [7, 4, 11, 11], [14], [7, 4, 11, 11], [14]
    end                                                 # => [[7, 4, 11, 11], [14]], [[7, 4, 11, 11], [14]]
    rotated_message                                     # => [25, 29, 8, 22, 32], [25, 29, 8, 22, 32]
  end

  def encrypt_message
    encrypt_message = rotate_message.map do |character|  # => [25, 29, 8, 22, 32]
      CHAR_MAP[character]                                # => "z", "3", "i", "w", "6"
    end                                                  # => ["z", "3", "i", "w", "6"]
    encrypt_message.join                                 # => "z3iw6"
  end

end
#
# # # # # #
new_encryptor = Encryptor.new("hello", 12345, 161215)  # => #<Encryptor:0x007fe14d841850 @message=["h", "e", "l", "l", "o"], @new_key=#<WheelGenerator:0x007fe14d841508 @key="12345", @date=161215, @key_rotation_a=12, @key_rotation_b=23, @key_rotation_c=34, @key_rotation_d=45>, @date=161215>
new_encryptor.message_value                            # => [7, 4, 11, 11, 14]
new_encryptor.slice_message                            # => [[7, 4, 11, 11], [14]]
new_encryptor.rotate_message                           # => [25, 29, 8, 22, 32]
new_encryptor.encrypt_message                          # => "z3iw6"
