class CommonFunction

  def self.validate_input(user_input)
    isValid = false
    return isValid if !(user_input.is_a? Array)
    unless user_input.any?
      return isValid
    else
      user_input.map do |item|
        if (item.is_a? Array) && (item.length == 2)
          isValid = true
          item.map{|i| isValid = false if !(i.is_a? Integer) }
        else
          isValid = false
          break
        end
      end
    end
    return isValid
  end

  def self.dispaly_seat_chart(seat_chart, number_of_passengers_in_queue)
    if (seat_chart.is_a? Array) && seat_chart.any?
      puts
      puts "Seat Arrangement Chart"
      seat_chart.each do |row|
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
  end

end
