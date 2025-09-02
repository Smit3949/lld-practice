class Place 
    def initialize
        @parking_lots = []
        @size = []
        @entries = []
        @exits = []
    end

    def add_parking_lot(parking_lot)
        @parking_lots << parking_lot
    end

    def remove_parking_lot(parking_lot)
        @parking_lots = @parking_lots.select { |pl| pl.id != parking_lot.id }
    end
end


class ParkingLot 
    def initialize(vehicle)
        @vehicle = vehicle
        @status = "free"
        @entry_at = Time.now
        @exit_at = nil
    end

    def cal_fair
        @vehicle.size * (exit_at - entry_at)
    end
end

class Ticket
    def initialize(vehicle, )
end


class Vehicle
    def initialize(size, number_plate)
        @size = size
        @number_plate = number_plate
    end
end

class Car < Vehicle
    def initialize(number_plate)
        super(4, number_plate)
    end
end

class Bike < Vehicle
    def initialize(number_plate)
        super(2, number_plate)
    end
end

class Truck < Vehicle
    def initialize(number_plate)
        super(6, number_plate)
    end
end

