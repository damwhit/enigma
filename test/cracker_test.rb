require 'minitest/autorun'
require 'minitest/pride'
require_relative 'test_helper'
require_relative '../lib/cracker'

class CrackerTest < Minitest::Test

  def test_cracker_can_receive_an_encrypted_message
    new_message = Cracker.new("hello")
    assert new_message
  end

  def test_cracker_converts_an_encrypted_message_to_indices
    new_message = Cracker.new("adsasdfad.")
    message_value = new_message.message_value[-7..-1]
    assert_equal [0, 18, 3, 5, 0, 3, 37], message_value
  end

  def test_cracker_can_find_original_value
    new_message = Cracker.new("hello..end..")
    original_value = new_message.original_value
    assert_equal [37, 37, 4, 13, 3, 37, 37], original_value
  end

  def test_difference_between_encrypted_values_and_original
    new_message = Cracker.new("hola senior")
    diff = new_message.difference
    assert_equal [1, 19, 0, 0, -5, 23, 20], diff
  end

  def test_slice_message_converts_encrypted_message_to_arrays_of_four_or_less
    new_message = Cracker.new("hello")
    sliced_message = new_message.slice_message
    assert sliced_message.count <= 4
  end

  def test_slice_message_does_not_convert_encrypted_message_to_array_longer_than_four
    new_message = Cracker.new("hello")
    sliced_message = new_message.slice_message
    refute sliced_message.count > 4
  end

  def test_cracker_can_find_message_value
    new_message = Cracker.new("hello")
    message_value = new_message.message_value
    assert_equal [7, 4, 11, 11, 14], message_value
  end

  def test_crack_message_yields_a_decrypted_message
    new_message = Cracker.new("z3iw6w8jw,ajq")
    new_message.message_value
    new_message.slice_message
    new_message.rotate_message
    cracked_message = new_message.crack_message
    assert_equal "hello ..end..", cracked_message
  end

end
