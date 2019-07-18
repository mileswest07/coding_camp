# frozen_string_literal: true

require './weapons'

RSpec.describe Weapons do
  subject { Weapons }
  let(:vehicle) do
    class Temp
      include Weapons
    end

    Temp.new
  end

  context 'methods' do
    it 'fires' do
      vehicle.fire!
      expect(vehicle).to be_truthy
    end
  end
end