# frozen_string_literal: true

require './flight'

RSpec.describe Flight do
  subject { Flight }
  let(:vehicle) do
    class Temp
      include Flight
      attr_reader :current_state, :speed

      def initialize
        @current_state = 'Something other than Drive or Flying'
        @speed = 0
      end

      def set_to_drive!
        @current_state = 'Drive'
      end

      def set_speed!(new_speed)
        @speed = new_speed
      end
    end

    Temp.new
  end

  context 'methods' do
    it 'starts flying when driving fast enough' do
      vehicle.set_to_drive!
      vehicle.fly!
      expect(vehicle.current_state).to eq('Flying')
      expect(vehicle.speed).to be > 600
    end

    it 'can not take off if vehicle is not driving' do
      expect(vehicle.current_state).to eq('Something other than Drive or Flying')
      start_time = Time.now
      vehicle.fly!
      total_time = Time.now - start_time
      expect(total_time).to be < 1.0
      expect(vehicle.speed).to be <= 600
    end

    it 'lands after having flown' do
      vehicle.set_to_drive!
      vehicle.fly!
      vehicle.land!
      expect(vehicle.current_state).to eq('Drive')
      expect(vehicle.speed).to be < 70
    end

    it 'can not land if vehicle is not flying' do
      expect(vehicle.current_state).to eq('Something other than Drive or Flying')
      start_time = Time.now
      vehicle.land!
      total_time = Time.now - start_time
      expect(total_time).to be < 1.0
      expect(vehicle.speed).to be_zero
    end
  end

  describe 'behaviors and limits' do
    context 'when flying' do
      it 'takes 13 seconds to take off and reach top speed from zero' do
        vehicle.set_to_drive!
        start_time = Time.now
        vehicle.fly!
        total_time = Time.now - start_time
        expect(total_time).to be_within(0.1).of(13.0)
      end

      it 'takes 11 seconds to take off and reach top speed from 100 mph' do
        vehicle.set_to_drive!
        vehicle.set_speed!(100)
        start_time = Time.now
        vehicle.fly!
        total_time = Time.now - start_time
        expect(total_time).to be_within(0.1).of(11.0)
      end

      it 'takes 1 second to take off and reach top speed from 600 mph' do
        vehicle.set_to_drive!
        vehicle.set_speed!(600)
        start_time = Time.now
        vehicle.fly!
        total_time = Time.now - start_time
        expect(total_time).to be_within(0.1).of(1.0)
      end

      it 'does not push the speed over the max if taking off at 601 mph' do
        vehicle.set_to_drive!
        vehicle.set_speed!(601)
        start_time = Time.now
        vehicle.fly!
        total_time = Time.now - start_time
        expect(total_time).to be_within(0.1).of(0.0)
      end
    end

    context 'when landing' do
      it 'takes 20 seconds to land after reaching top speed' do
        vehicle.set_to_drive!
        vehicle.fly!
        start_time = Time.now
        vehicle.land!
        total_time = Time.now - start_time
        expect(total_time).to be_within(0.1).of(20.0)
      end

      it 'takes 2 seconds to land from flight speed of 101 mph' do
        vehicle.set_to_drive!
        vehicle.fly!
        vehicle.set_speed!(101)
        start_time = Time.now
        vehicle.land!
        total_time = Time.now - start_time
        expect(total_time).to be_within(0.1).of(2.0)
      end

      it 'takes 1 second to land from flight speed of 99 mph' do
        vehicle.set_to_drive!
        vehicle.fly!
        vehicle.set_speed!(99)
        start_time = Time.now
        vehicle.land!
        total_time = Time.now - start_time
        expect(total_time).to be_within(0.1).of(1.0)
      end

      it 'does not push the speed under the minimum for landing' do
        vehicle.set_to_drive!
        vehicle.fly!
        vehicle.set_speed!(69)
        start_time = Time.now
        vehicle.land!
        total_time = Time.now - start_time
        expect(total_time).to be_within(0.1).of(0.0)
      end
    end
  end
end