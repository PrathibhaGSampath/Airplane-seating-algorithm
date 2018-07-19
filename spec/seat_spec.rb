require_relative '../seat.rb'

describe Seat do
  describe "#get_seating_chart" do
    context "For input other than array of 2D array(s)" do
      it "should return nil" do
        def create_input_hash
          input_hash = {}
          input_hash[:input_nil] = nil
          input_hash[:input_empty_string] = ""
          input_hash[:input_empty_array] = []
          input_hash[:input_integer] = 1
          input_hash[:input_integer_array] = [1]
          input_hash[:input_2D_array] = [1, 3]
          input_hash[:input_3D_array] = [1,2,3]
          input_hash[:input_array_of_3D_array] = [[1,2,3]]
          input_hash[:input_array_of_2D_and_3D_arrays] = [[3,2], [2,1,3]]

          return input_hash
        end
        passengers_count = 2
        input_hash = create_input_hash
        input_hash.each do |key, input|
          seat = Seat.new(input)
          matrix = seat.get_seating_chart(passengers_count)
          expect(matrix).to be_nil
        end
      end
    end

    context "For input array of 2D array with one column" do
      it "should return arranged seat matrix" do
        input = [[2,1]]
        passengers_count = 2

        seat = Seat.new(input)
        matrix = seat.get_seating_chart(passengers_count)
        expect(matrix).to eq ([[[[2, 1]]], 0])
      end
    end

    context "For input array of 2D array with one row" do
      it "should return arranged seat matrix" do
        input = [[1,2]]
        passengers_count = 2

        seat = Seat.new(input)
        matrix = seat.get_seating_chart(passengers_count)
        expect(matrix).to eq ([[[[1]], [[2]]], 0])
      end
    end

    context "For passenger_count 0 or Nil" do
      it "should return seat matrix with no passenger is allocated" do
        input = [[2,1]]
        passengers_count = nil

        seat = Seat.new(input)
        matrix = seat.get_seating_chart(passengers_count)
        expect(matrix).to eq ([[[["XX", "XX"]]], 0])
      end
    end

    context "For input array of 2D arrays and valid passenger count" do
      it "should return arranged seat matrix" do
        input = [[3,2], [3,4], [2,3]]
        passengers_count = 21

        seat = Seat.new(input)
        matrix = seat.get_seating_chart(passengers_count)
        expect(matrix).to eq ([[[[14, 19, 1], [2, 20, 3], [4, 15]], [[16, 21, 5], [6, "XX", 7], [8, 17]], [[], [9, "XX", 10], [11, 18]], [[], [12, "XX", 13], []]], 0])
      end
    end
  end
end
