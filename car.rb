class Car
  attr_reader :speed, :current_state, :on_or_off

  def initialize
    @speed = 0
    @current_state = 'Park'
    @on_or_off = 'Off'
    @seatbelt_fastened = false
  end

  def seatbelt_fastened?
    @seatbelt_fastened
  end

  def on!
    @on_or_off = 'On' if before_turn_on
  end

  def off!
    @on_or_off = 'Off'
  end

  def drive!
    @current_state = 'Drive' if before_drive
  end

  def park!
    @current_state = 'Park' if before_park
  end

  def reverse!
    @current_state = 'Reverse' if @speed.zero? && before_drive
  end

  def fasten_seatbelts!
    @seatbelt_fastened = true
  end

  def accelerate!
    @speed += 5 if before_drive
  end

  def decelerate!
    @speed -= 5
  end

  def before_park
    @speed.zero? && @current_state != 'Off'
  end

  def before_drive
    seatbelt_fastened? || false
  end

  def before_turn_on
    @current_state == 'Park'
  end

end