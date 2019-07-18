require './car'
require './hyperdrive'
require './flight'
require './weapons'

class Carship < Car
  include Hyperdrive
  include Flight
  include Weapons
end