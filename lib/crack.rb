require_relative 'cracker'

class Crack

message = File.read(ARGV[0]).chomp

date = (Time.now.strftime("%d%m%y").to_i)

cracked_message = Cracker.new(message).crack_message

File.write(ARGV[1], cracked_message)

puts "Created '#{ARGV[1]}' with the key and date "

end
