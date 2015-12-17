require_relative 'decryptor'

class Decrypt

message = File.read(ARGV[0]).chomp
key = [*0..9].sample(5).join.to_i
date = (Time.now.strftime("%d%m%y").to_i)

decrypted_message = Decryptor.new(message, key, date).decrypt_message

File.write(ARGV[1], decrypted_message)

puts "Created '#{ARGV[1]}' with the key #{key} and date #{date}"

end
