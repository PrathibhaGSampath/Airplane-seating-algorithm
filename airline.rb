require_relative 'seating_arrangement'

# input =  [[3,2], [3, 4], [2,3]]
# passanger_count = 21
class Airline

  def book_seat(seat_matrix, passanger_count)
    if CommonFunction.validate_input(seat_matrix)
      seat = SeatingArrangement.new(seat_matrix)
      (seating_chart, number_of_passengers_in_queue) = seat.get_seating_chart(passanger_count)

      if (seating_chart.is_a? Array) && seating_chart.any?
        puts
        puts "Seat Arrangement Chart"
        seating_chart.each do |row|
          row.each do |matrix|
            print  matrix if matrix.any?
            print  " " * 2
            print  " " * 10 unless matrix.any?
          end
          puts
        end
        puts "Number of passangers waiting in queue: #{number_of_passengers_in_queue}"
      else
        puts "Invalid Input Type"
      end
    else
      puts "Invalid Input Type"
    end
  end
end
