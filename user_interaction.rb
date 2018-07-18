require_relative 'airline'
require_relative 'common_function'

user_input = Array.new()
puts "Enter number of seat matrix arrangement in Flight:"
number_of_seats_matrices = gets.chomp.to_i
number_of_seats_matrices.times do |number|
  puts "Number of row(s) in of seat matrix #{number}"
  row = gets.chomp.to_i
  puts "Number of column(s) in of seat matrix #{number}"
  column = gets.chomp.to_i
  user_input << [row, column]
end

puts "Enter number of Passangers:"
passangers_count = gets.chomp.to_i

airline = Airline.new()
(seat_chart, queue_count) = airline.seat_arrangement(user_input, passangers_count)
CommonFunction.dispaly_seat_chart(seat_chart, queue_count)
