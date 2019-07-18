module Flight
  def fly!
    return if @current_state != 'Drive'
    until @speed > 600
      @speed += 50
      @current_state = 'Flying' if @speed >= 100
      sleep 1
    end
    @current_state = 'Flying' if @speed >= 100
  end

  def land!
    return if @current_state != 'Flying'
    until @speed < 70
      @speed -= 30
      sleep 1
      @current_state = 'Drive' if @speed < 100
    end
    @current_state = 'Drive' if @speed < 100
  end
end