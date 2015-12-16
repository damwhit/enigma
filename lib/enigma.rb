require_relative 'wheel_generator'
require_relative 'encryptor'
require_relative 'decryptor'
require_relative 'crack'

class Enigma
  def initialize
    @new_key = WheelGenerator.new(54321, 151215)
  end

  def encrypt(message, key = [*0..9].sample(5).join, date = (Time.now.strftime("%d%m%y").to_i))
    @new_key ||=  WheelGenerator.new(key, date)
    Encryptor.new(message, @new_key).encrypt_message
  end

  def decrypt(message, key = [*0..9].sample(5).join, date = (Time.now.strftime("%d%m%y").to_i))
    @new_key ||=  WheelGenerator.new(key, date = (Time.now.strftime("%d%m%y").to_i))
    Decryptor.new(message, @new_key).decrypt_message
  end

  def crack(encrypted_message)
    Crack.new(encrypted_message).crack_message
  end

end

new_engine = Enigma.new

new_engine.encrypt("hello..end..")
new_engine.decrypt(".6bi5zwt w 2ww,z47krpx8p528j")
new_engine.crack("2kg.9e648j6y")
