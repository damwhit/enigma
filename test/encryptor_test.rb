require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/encryptor'

class EncryptorTest < Minitest::Test

  def test_encryptor_can_receive_a_message_and_break_into_chars
    new_message = Encryptor.new("hello", 12345)
    assert_equal "hello".chars, new_message.message
  end

  def test_message_value_converts_a_message_to_indices
    new_message = Encryptor.new("hello", 12345)
    message_value = new_message.message_value
    assert_equal [7, 4, 11, 11, 14], message_value
  end

  def test_slice_message_converts_message_to_arrays_of_four_or_less
    new_message = Encryptor.new("hello", 12345)
    sliced_message = new_message.slice_message
    assert sliced_message.count <= 4
  end

  def test_slice_message_does_not_convert_message_to_array_longer_than_four
    new_message = Encryptor.new("hello", 12345)
    sliced_message = new_message.slice_message
    refute sliced_message.count > 4
  end

  def test_message_rotates_the_correct_amount
    new_message = Encryptor.new("hello", 12345)
    rotated_message = new_message.rotate_message
    assert_equal ["25", "29", "8", "23", "32"], rotated_message
  end


end
