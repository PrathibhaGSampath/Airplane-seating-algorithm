require_relative 'seat'

# input =  [[3,2], [3, 4], [2,3]]
# passanger_count = 21
class Airline

  def seat_arrangement(seat_matrix, passanger_count)
    return Seat.new(seat_matrix).get_seating_chart(passanger_count)
  end
end
