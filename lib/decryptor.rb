  require_relative 'wheel_generator'  # => true
class Decryptor
  attr_reader :message, :new_key      # => nil
  CHAR_MAP = ["a", "b", "c", "d",     # => "d"
              "e", "f", "g", "h",     # => "h"
              "i", "j", "k", "l",     # => "l"
              "m", "n", "o", "p",     # => "p"
              "q", "r", "s", "t",     # => "t"
              "u", "v", "w", "x",     # => "x"
              "y", "z", "0", "1",     # => "1"
              "2", "3", "4", "5",     # => "5"
              "6", "7", "8", "9",     # => "9"
              " ", ".", ","]          # => ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", " ", ".", ","]

  def initialize(message, key, date)
    @message = message.chars                      # => ["z", "3", "i", "w", "6"]
    @new_key = WheelGenerator.new(12345, 161215)  # => #<WheelGenerator:0x007f8c8a931318 @key="12345", @date=161215, @key_rotation_a=12, @key_rotation_b=23, @key_rotation_c=34, @key_rotation_d=45>
    @date = date                                  # => 161215
  end

  def message_value
    message_value = message.map do |character|  # => ["z", "3", "i", "w", "6"], ["z", "3", "i", "w", "6"], ["z", "3", "i", "w", "6"], ["z", "3", "i", "w", "6"]
      CHAR_MAP.index(character)                 # => 25, 29, 8, 22, 32, 25, 29, 8, 22, 32, 25, 29, 8, 22, 32, 25, 29, 8, 22, 32
    end                                         # => [25, 29, 8, 22, 32], [25, 29, 8, 22, 32], [25, 29, 8, 22, 32], [25, 29, 8, 22, 32]
  end

  def slice_message
    sliced_message  = []                        # => [], [], []
    message_value.each_slice(4) do |character|  # => [25, 29, 8, 22, 32], [25, 29, 8, 22, 32], [25, 29, 8, 22, 32]
      sliced_message << character               # => [[25, 29, 8, 22]], [[25, 29, 8, 22], [32]], [[25, 29, 8, 22]], [[25, 29, 8, 22], [32]], [[25, 29, 8, 22]], [[25, 29, 8, 22], [32]]
    end                                         # => nil, nil, nil
    sliced_message                              # => [[25, 29, 8, 22], [32]], [[25, 29, 8, 22], [32]], [[25, 29, 8, 22], [32]]
  end

  def rotate_message
    rotated_message = []                                # => [], []
    slice_message.each do |array|                       # => [[25, 29, 8, 22], [32]], [[25, 29, 8, 22], [32]]
      array.each.with_index do |character, index|       # => #<Enumerator: [25, 29, 8, 22]:each>, #<Enumerator: [32]:each>, #<Enumerator: [25, 29, 8, 22]:each>, #<Enumerator: [32]:each>
        rotation = if index == 0                        # => true, false, false, false, true, true, false, false, false, true
          @new_key.final_rotation_a                     # => 18, 18, 18, 18
        elsif index == 1                                # => true, false, false, true, false, false
          @new_key.final_rotation_b                     # => 25, 25
        elsif index == 2                                # => true, false, true, false
          @new_key.final_rotation_c                     # => 36, 36
        elsif index == 3                                # => true, true
          @new_key.final_rotation_d                     # => 50, 50
        end                                             # => 18, 25, 36, 50, 18, 18, 25, 36, 50, 18
        rotated_message << (character - rotation) % 39  # => [7], [7, 4], [7, 4, 11], [7, 4, 11, 11], [7, 4, 11, 11, 14], [7], [7, 4], [7, 4, 11], [7, 4, 11, 11], [7, 4, 11, 11, 14]
      end                                               # => [25, 29, 8, 22], [32], [25, 29, 8, 22], [32]
    end                                                 # => [[25, 29, 8, 22], [32]], [[25, 29, 8, 22], [32]]
    rotated_message                                     # => [7, 4, 11, 11, 14], [7, 4, 11, 11, 14]
  end

  def decrypt_message
    decrypt_message = rotate_message.map do |character|  # => [7, 4, 11, 11, 14]
      CHAR_MAP[character]                                # => "h", "e", "l", "l", "o"
    end                                                  # => ["h", "e", "l", "l", "o"]
    decrypt_message.join                                 # => "hello"
  end

end
#
# #
new_decryptor = Decryptor.new("z3iw6", 12345, 161215)  # => #<Decryptor:0x007f8c8a931660 @message=["z", "3", "i", "w", "6"], @new_key=#<WheelGenerator:0x007f8c8a931318 @key="12345", @date=161215, @key_rotation_a=12, @key_rotation_b=23, @key_rotation_c=34, @key_rotation_d=45>, @date=161215>
new_decryptor.message_value                            # => [25, 29, 8, 22, 32]
new_decryptor.slice_message                            # => [[25, 29, 8, 22], [32]]
new_decryptor.rotate_message                           # => [7, 4, 11, 11, 14]
new_decryptor.decrypt_message                          # => "hello"
