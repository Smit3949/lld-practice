class Place 
  def initialize
    @parking_lots = []
    @tickets = []
  end

  def add_parking_lot(parking_lot)
    @parking_lots << parking_lot
  end

  def remove_parking_lot(parking_lot)
    @parking_lots.reject! { |pl| pl.object_id == parking_lot.object_id }
  end

  def find_parking_lot(size) 
    @parking_lots.find {|pl| pl.status == "free" && pl.size == size }
  end

  def issue_ticket(vehicle)
    parking_lot = find_parking_lot(vehicle.size)
    raise "No available parking lot for vehicle size #{vehicle.size}" if parking_lot.nil?
    ticket = Ticket.new(vehicle, parking_lot)
    @tickets << ticket
    ticket
  end
end


class ParkingLot 
  attr_accessor :status, :size

  def initialize(size)
    @status = "free"
    @size = size
  end
end


class Ticket
  def initialize(vehicle, parking_lot)
    @parking_lot = parking_lot
    @vehicle = vehicle
    @entry_at = Time.now
    @exit_at = nil

    if @parking_lot.status != "free"
      raise "Parking Lot is not free you cannot assign"
    end
    if @parking_lot.size < @vehicle.size
      raise "Parking lot is too small for this vehicle!"
    end

    @parking_lot.status = "occupied"
  end

  def exit!
    @exit_at = Time.now
    @parking_lot.status = "free"
  end

  def cal_fair
    if @exit_at.nil?
      raise "Vehicle is still there in parking lot!!"
    end
    # Example: 1 unit size * 1 second = 1 fare unit
    @vehicle.size * (@exit_at - @entry_at)
  end
end


class Vehicle
  attr_reader :size, :number_plate

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

place = Place.new
parking_lot_for_car = ParkingLot.new(4)
parking_lot_for_bike = ParkingLot.new(2)
parking_lot_for_truck = ParkingLot.new(6)
place.add_parking_lot(parking_lot_for_car)
place.add_parking_lot(parking_lot_for_bike)
place.add_parking_lot(parking_lot_for_truck)
car = Car.new("CAR123")
bike = Bike.new("BIKE123")
truck = Truck.new("TRUCK123")
car_ticket = place.issue_ticket(car)


