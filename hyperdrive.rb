module Hyperdrive
  def calculate_path!(destination)
    @path_calculated = true
  end

  def engage!
    @previous_state = @current_state
    @current_state = 'Hyperdrive' if @path_calculated
    sleep 3
    disengage!
  end

  def disengage!
    @current_state = @previous_state
    @path_calculated = false
  end
end