class WheelGenerator
  attr_accessor :key, :date

  def initialize(key = [*0..9].sample(5).join, date = (Time.now.strftime("%d%m%y").to_i) )
    @key = key.to_s
    @date = date
    date_offset
    key_rotation
  end

  def date_offset
  (@date**2).to_s
  end

  def key_rotation
    @key_rotation_a = @key[0..1].to_i
    @key_rotation_b = @key[1..2].to_i
    @key_rotation_c = @key[2..3].to_i
    @key_rotation_d = @key[3..4].to_i
  end

  def final_rotation_a
    @key_rotation_a + date_offset[-4].to_i
  end

  def final_rotation_b
    @key_rotation_b + date_offset[-3].to_i
  end

  def final_rotation_c
    @key_rotation_c + date_offset[-2].to_i
  end

  def final_rotation_d
    @key_rotation_d + date_offset[-1].to_i
  end
end

new_wheel = WheelGenerator.new(12345, 151215)
new_wheel.date_offset
new_wheel.final_rotation_a
new_wheel.final_rotation_b
new_wheel.final_rotation_c
new_wheel.final_rotation_d
