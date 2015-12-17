require_relative 'wheel_generator'
require_relative 'encryptor'
require_relative 'decryptor'
require_relative 'cracker'

class Enigma
  def initialize
    @new_key = WheelGenerator.new(key = [*0..9].sample(5).join, date = (Time.now.strftime("%d%m%y").to_i))
  end

  def encrypt(message, key = [*0..9].sample(5).join, date = (Time.now.strftime("%d%m%y").to_i))
    @new_key ||=  WheelGenerator.new(key, date)
    Encryptor.new(message, @new_key, date).encrypt_message
  end

  def decrypt(message, key = [*0..9].sample(5).join, date = (Time.now.strftime("%d%m%y").to_i))
    @new_key ||=  WheelGenerator.new(key, date = (Time.now.strftime("%d%m%y").to_i))
    Decryptor.new(message, @new_key, date).decrypt_message
  end

  def crack(encrypted_message)
    Cracker.new(encrypted_message).crack_message
  end

end
