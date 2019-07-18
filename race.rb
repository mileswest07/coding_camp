require './carship'

module Race
  def self.go(car)
    prepare_to_fly(car)
    car.fly!
    car.calculate_path!("Gallifrey")
    car.engage!
    car.land!
  end

  def self.prepare_to_fly(car)
    car.on!
    car.fasten_seatbelts!
    car.drive!
  end

  def self.run_car(car_number)
    start_time = Time.now
    car = Carship.new
    go(car)
    total_time = Time.now - start_time
    puts "Car #{car_number} reached its destination in #{total_time} seconds"
  end

  def self.start
    4.times do |i|
      fork { run_car(i) }
    end
  end
end
