require 'minitest/autorun'
require 'minitest/pride'
require_relative 'test_helper'
require_relative '../lib/decryptor'

class DecryptorTest < Minitest::Test

  def test_decryptor_can_receive_an_encrypted_message_and_break_into_chars
    new_message = Decryptor.new("hello", 12345, 161215)
    assert_equal "hello".chars, new_message.message
  end

  def test_message_value_converts_an_encrypted_message_to_indices
    new_message = Decryptor.new("hello", 12345, 161215)
    message_value = new_message.message_value
    assert_equal [7, 4, 11, 11, 14], message_value
  end

  def test_slice_message_converts_encrypted_message_to_arrays_of_four_or_less
    new_message = Decryptor.new("hello", 12345, 161215)
    sliced_message = new_message.slice_message
    assert sliced_message.count <= 4
  end

  def test_slice_message_does_not_convert_encrypted_message_to_array_longer_than_four
    new_message = Decryptor.new("hello", 12345, 161215)
    sliced_message = new_message.slice_message
    refute sliced_message.count > 4
  end

  def test_encrypted_message_rotates_back_the_correct_amount
    new_message = Decryptor.new("hello", 12345, 161215)
    new_message.message_value
    new_message.slice_message
    rotated_message = new_message.rotate_message
    assert_equal [28, 18, 14, 0, 35], rotated_message
  end

  def test_encrypted_message_does_not_rotate_the_incorrect_amount
    new_message = Decryptor.new("hello", 12345, 161215)
    new_message.message_value
    new_message.slice_message
    rotated_message = new_message.rotate_message
    refute_equal [25, 22, 8, 22, 32], rotated_message
  end

  def test_decrypt_message_yields_a_string
    new_message = Decryptor.new("z3iw6", 12345, 161215)
    new_message.message_value
    new_message.slice_message
    new_message.rotate_message
    decrypted_message = new_message.decrypt_message
    assert_equal "hello", decrypted_message
  end

  def test_decrypt_will_not_yield_a_fixnum
    new_message = Decryptor.new("hello", 12345, 161215)
    new_message.message_value
    new_message.slice_message
    new_message.rotate_message
    decrypted_message = new_message.decrypt_message
    refute_equal 12345, decrypted_message
  end

  def test_decrypt_message_yields_an_decrypted_message
    new_message = Decryptor.new("z3iw6w8jw,ajq", 12345, 161215)
    new_message.message_value
    new_message.slice_message
    new_message.rotate_message
    decrypted_message = new_message.decrypt_message
    assert_equal "hello ..end..", decrypted_message
  end

  def test_decrypt_message_yields_a_string_the_same_length_as_original_message
    new_message = Decryptor.new("hello ..end..", 12345, 161215)
    decrypted_message = new_message.decrypt_message
    assert_equal 13, decrypted_message.length
  end

end
