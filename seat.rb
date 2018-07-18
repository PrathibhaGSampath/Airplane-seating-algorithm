require_relative 'common_function'

class Seat
  def initialize(seat_matrix)
    @seat_matrix = seat_matrix
  end

  def get_seating_chart(passengers_count)
    if CommonFunction.validate_input(@seat_matrix)
      arrangement
      management(passengers_count)
      return arrange_seat_matrix, @queue_count
    else
      return []
    end
  end

  def arrangement
    @total_number_of_seats_available = 0
    @seat_matrix.map{|i| @total_number_of_seats_available += (i.first * i.last)}
    @seat_matrix = rowwise_seat_matrix
  end

  def management(passengers_count)
    @total_number_of_passenger = passengers_count
    @queue_count = 0
    #Counting Number of Passengers in Queue.
    if @total_number_of_passenger > @total_number_of_seats_available
      @queue_count = @total_number_of_passenger - @total_number_of_seats_available
    end
  end

  private

  def arrange_seat_matrix
    count = 1
    #Assigning aisel seats numbers
    if count <= @total_number_of_passenger
      result = assign_seats_number("aisel", count)
      @seat_matrix = result[:numbered_matrix]
      count = result[:count]
    end

    #Assigning windows seats numbers
    if count <= @total_number_of_passenger
      result = assign_seats_number("window",count)
      @seat_matrix = result[:numbered_matrix]
      count = result[:count]
    end

    #Assigning middle seats numbers
    if count <= @total_number_of_passenger
      result = assign_seats_number("middle", count)
      @seat_matrix = result[:numbered_matrix]
    end

    return @seat_matrix
  end

  #Method to create row wise seat matrix
  def rowwise_seat_matrix
    number_of_columns = []
    @seat_matrix.map{|item| number_of_columns << item.last}
    number_of_rows = number_of_columns.flatten.uniq.max
    result =[]
    number_of_rows.times do |row|
      row_array = Array.new()
      @seat_matrix.each do |seat_matrix|
        unless seat_matrix.last <= row
         row_array << Array.new(seat_matrix.first, "XX") #Initializing array with string value "XX"
        else
          row_array << []
        end
      end
      result << row_array
    end
    return result
  end

  def assign_seats_number(seat_type, count)
    response = {}
    response[:numbered_matrix] = []
    @seat_matrix.each do |row_matrix|
      seat_method_type = case seat_type.upcase
      when "AISEL"
        result = number_aisel_seats(row_matrix, count)
      when "WINDOW"
        result = number_window_seats(row_matrix, count)
      when "MIDDLE"
          result = number_middle_seats(row_matrix, count)
      else
        response[:numbered_matrix] << result[:seat_matrix]
        response[:count] = 1
      end
      response[:numbered_matrix] = @seat_matrix
      response[:count] = count = result[:count]
    end
    return response
  end

  def number_aisel_seats(row_matrix, count)
    row_matrix.each do |matrix|
      if count <= @total_number_of_passenger
        if matrix == row_matrix.first
          #Assigning seat number for first row's first matrix
           if (matrix.last == "XX")
             matrix[matrix.size - 1] = count
             count += 1
           end
        elsif matrix == row_matrix.last
          #Assigning seat number for first row's last matrix
          if (matrix.first == "XX")
            matrix[0] = count
            count += 1
          end
        else
          #Assigning seat number for first row's rest of the matrices
          if (matrix.first == "XX")
            matrix[0] = count
            count += 1
          end
          if (matrix.last == "XX")
            matrix[matrix.size - 1] = count
            count += 1
          end
        end
      end
    end

    result = {}
    result[:seat_matrix] = row_matrix
    result[:count] = count

    return result
  end

  def number_window_seats(row_matrix, count)
    if count <= @total_number_of_passenger
        #Assigning seat number for first row's first matrix
       if (row_matrix.first.first == "XX")
         row_matrix.first[0] = count
         count += 1
       end
      #Assigning seat number for first row's last matrix
      if (row_matrix.last.last == "XX")
        row_matrix.last[row_matrix.last.size - 1] = count
        count += 1
      end
    end
    result = {}
    result[:seat_matrix] = row_matrix
    result[:count] = count

    return result
  end

  def number_middle_seats(row_matrix, count)
    row_matrix.each do |matrix|
      for index in (1...matrix.count - 1)
        #Assigning seat number for all the matrices
          if count <= @total_number_of_passenger
            matrix[index] = count
            count += 1
          end
      end
    end
    result = {}
    result[:seat_matrix] = row_matrix
    result[:count] = count

    return result
  end


end
