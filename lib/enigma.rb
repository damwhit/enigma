require_relative 'wheel_generator'  # => true
require_relative 'encryptor'        # => true
require_relative 'decryptor'        # => true
require_relative 'crack'            # => true

class Enigma
  def initialize
    @new_key = WheelGenerator.new(12345, 161215)  # => #<WheelGenerator:0x007fa7a28a75b8 @key="12345", @date=161215, @key_rotation_a=12, @key_rotation_b=23, @key_rotation_c=34, @key_rotation_d=45>
  end

  def encrypt(message, key = [*0..9].sample(5).join, date = (Time.now.strftime("%d%m%y").to_i))
    @new_key ||=  WheelGenerator.new(key, date)                                                  # => #<WheelGenerator:0x007fa7a28a75b8 @key="12345", @date=161215, @key_rotation_a=12, @key_rotation_b=23, @key_rotation_c=34, @key_rotation_d=45>
    Encryptor.new(message, @new_key, date).encrypt_message                                       # => "z3iw6x8p528j"
  end

  def decrypt(message, key = [*0..9].sample(5).join, date = (Time.now.strftime("%d%m%y").to_i))
    @new_key ||=  WheelGenerator.new(key, date = (Time.now.strftime("%d%m%y").to_i))             # => #<WheelGenerator:0x007fa7a28a75b8 @key="12345", @date=161215, @key_rotation_a=12, @key_rotation_b=23, @key_rotation_c=34, @key_rotation_d=45>
    Decryptor.new(message, @new_key, date).decrypt_message                                       # => "the nazis are coming ..end.."
  end

  def crack(encrypted_message)
    Crack.new(encrypted_message).crack_message  # => "hello..end.."
  end

end

new_engine = Enigma.new  # => #<Enigma:0x007fa7a28a75e0 @new_key=#<WheelGenerator:0x007fa7a28a75b8 @key="12345", @date=161215, @key_rotation_a=12, @key_rotation_b=23, @key_rotation_c=34, @key_rotation_d=45>>

new_engine.encrypt("hello..end..")                  # => "z3iw6x8p528j"
new_engine.decrypt(".6bi5zwt w 2ww,z47krpx8p528j")  # => "the nazis are coming ..end.."
new_engine.crack("2kg.9e648j6y")                    # => "hello..end.."
