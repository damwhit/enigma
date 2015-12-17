require_relative 'encryptor'

class Encrypt

message = File.read(ARGV[0]).chomp
key = [*0..9].sample(5).join.to_i
date = (Time.now.strftime("%d%m%y").to_i)

encrypted_message = Encryptor.new(message, key, date).encrypt_message

File.write(ARGV[1], encrypted_message)

puts "Created '#{ARGV[1]}' with the key #{key} and date #{date}"

end
