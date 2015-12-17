class Cracker
  attr_reader :message

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

  def initialize(encrypted_message)
    @message = encrypted_message.chars
  end

  def end_value
    @message[-7..-1].map do |character|
      CHAR_MAP.index(character)
    end
  end

  def original_value
    "..end..".chars.map do |character|
      CHAR_MAP.index(character)
    end
  end

  def difference
    end_value.zip(original_value).map { |x, y| y - x }
  end

  def find_rotators
    if (@message.length % 4) == 0
      difference[-4..-1]
    elsif @message.length % 4 ==1
      difference[-5..-2]
    elsif @message.length % 4 == 2
      difference[-6..-3]
    elsif @message.length % 4 == 3
      difference[-7..-4]
    end
  end

  def message_value
    message_value = @message.map do |character|
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
          find_rotators[0]
        elsif index == 1
          find_rotators[1]
        elsif index == 2
          find_rotators[2]
        elsif index == 3
          find_rotators[3]
        end
        rotated_message << (character + rotation) % 39
      end
    end
    rotated_message
  end

  def crack_message
    crack_message = rotate_message.map do |character|
      CHAR_MAP[character]
    end
    crack_message.join
  end
end
