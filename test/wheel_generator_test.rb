require 'minitest/autorun'
require 'minitest/pride'
require_relative 'test_helper'
require_relative '../lib/wheel_generator'

class WheelGeneratorTest < Minitest::Test

  def test_offset_calculator_can_make_a_key_and_date
    new_wheel = WheelGenerator.new(12345, 121215)
    assert_equal "12345", new_wheel.key
    assert_equal 121215, new_wheel.date
  end


  def test_key_values_are_not_the_same_twice
    new_wheel = WheelGenerator.new
    new_wheel2 = WheelGenerator.new
    refute new_wheel.key ==new_wheel2.key
  end

  def test_offset_calculator_can_make_a_five_digit_key
    new_wheel = WheelGenerator.new
    assert_equal 5, new_wheel.key.length
  end

  def test_key_rotation_is_a_one_or_two_digit_number
    new_wheel = WheelGenerator.new
    assert new_wheel.key_rotation.to_s.length <= 2
  end

  def test_final_rotation_is_a_one_or_two_digit_number
    new_wheel = WheelGenerator.new
    new_wheel.key_rotation
    new_wheel.final_rotation_a
    assert new_wheel.final_rotation_a.to_s.length <= 2
  end

  def test_key_rotations_are_not_the_same_twice
    new_wheel = WheelGenerator.new
    new_wheel2 = WheelGenerator.new
    rotate1 = new_wheel.key_rotation
    rotate2 = new_wheel2.key_rotation
    refute rotate1 == rotate2
  end

end
