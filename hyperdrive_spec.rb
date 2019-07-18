# frozen_string_literal: true

require './hyperdrive'

RSpec.describe Hyperdrive do
  subject { Hyperdrive }
  let(:vehicle) do
    class Temp
      include Hyperdrive
      attr_reader :current_state, :path_calculated, :previous_state

      def initialize
        @current_state = 'Something other than Hyperdrive'
        @previous_state = 'Nothing'
        @path_calculated = false
      end
    end

    Temp.new
  end

  context 'methods' do
    it 'calculates the path' do
      vehicle.calculate_path!('Solla Sollew')
      expect(vehicle.path_calculated).to eq(true)
    end

    it 'disengages engines when commanded' do
      vehicle.calculate_path!('Solla Sollew')
      vehicle.disengage!
      expect(vehicle.path_calculated).to be_falsey
      expect(vehicle.current_state).to eq('Nothing')
    end

    it 'engages engines when commanded, then disengages when complete' do
      vehicle.calculate_path!('Solla Sollew')
      vehicle.engage!
      expect(vehicle.current_state).to eq('Something other than Hyperdrive')
      expect(vehicle.previous_state).to eq('Something other than Hyperdrive')
      expect(vehicle.path_calculated).to be_falsey
    end

    it 'takes three seconds to engage engines and finish hyperdrive' do
      vehicle.calculate_path!('Solla Sollew')
      start_time = Time.now
      vehicle.engage!
      total_time = Time.now - start_time
      expect(total_time).to be_within(0.1).of(3.0)
    end
  end

  describe 'path calculated' do
    it 'defaults to no path calculated' do
      expect(vehicle.path_calculated).to be_falsey
    end
  end

  describe 'previous state' do
    it 'defaults to nothing' do
      expect(vehicle.previous_state).to eq('Nothing')
    end
  end

  describe 'current state' do
    it 'defaults to something other than Hyperdrive' do
      expect(vehicle.current_state).to eq('Something other than Hyperdrive')
    end
  end
end