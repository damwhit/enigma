class WheelGenerator
  attr_accessor :key, :date  # => nil

  def initialize(key = [*0..9].sample(5).join, date = (Time.now.strftime("%d%m%y").to_i) )
    @key = key.to_s                                                                         # => "12345"
    @date = date                                                                            # => 151215
    date_offset                                                                             # => "22865976225"
    key_rotation                                                                            # => 45
  end

  def date_offset
  (@date**2).to_s  # => "22865976225", "22865976225", "22865976225", "22865976225", "22865976225", "22865976225"
  end

  def key_rotation
    @key_rotation_a = @key[0..1].to_i  # => 12
    @key_rotation_b = @key[1..2].to_i  # => 23
    @key_rotation_c = @key[2..3].to_i  # => 34
    @key_rotation_d = @key[3..4].to_i  # => 45
  end

  def final_rotation_a
    @key_rotation_a + date_offset[-4].to_i  # => 18
  end

  def final_rotation_b
    @key_rotation_b + date_offset[-3].to_i  # => 25
  end

  def final_rotation_c
    @key_rotation_c + date_offset[-2].to_i  # => 36
  end

  def final_rotation_d
    @key_rotation_d + date_offset[-1].to_i  # => 50
  end
end
                 # => 50
