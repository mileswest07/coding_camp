# frozen_string_literal: true

require './car'

RSpec.describe Car do
  subject { car }
  let(:car) { Car.new }

  context 'methods' do
    it 'sets the power state to on when turned on' do
      car.on!
      expect(car.current_state).to eq('Park')
      expect(car.on_or_off).to eq('On')
    end

    it 'sets the power state to off when turned off' do
      car.off!
      expect(car.on_or_off).to eq('Off')
    end

    it 'sets the transmission state to drive when put in drive' do
      car.on!
      car.fasten_seatbelts!
      car.drive!
      expect(car.current_state).to eq('Drive')
    end

    it 'sets the transmission state to park when put in park ' do
      car.on!
      car.fasten_seatbelts!
      car.drive!
      car.park!
      expect(car.current_state).to eq('Park')
    end

    it 'sets the transmission state to reverse when put in reverse on' do
      car.on!
      car.fasten_seatbelts!
      car.drive!
      car.reverse!
      expect(car.current_state).to eq('Reverse')
    end

    it 'puts on seatbelts when asked' do
      car.fasten_seatbelts!
      is_expected.to be_seatbelt_fastened
    end

    context 'speed!' do
      before do
        car.on!
        car.fasten_seatbelts!
        car.drive!
        car.accelerate!
      end

      it 'it increases the speed by five when accelerating' do
        expect(car.speed).to eq(5)
        car.accelerate!
        expect(car.speed).to eq(10)
      end

      it 'it decreases the speed by five when decelerating' do
        car.decelerate!
        expect(car.speed).to be_zero
      end
    end
  end

  describe 'transmission state' do
    it 'defaults to the parked state' do
      expect(car.current_state).to eq('Park')
    end
  end

  describe 'speed' do
    it 'defaults to a speed of zero' do
      expect(car.speed).to be_zero
    end
  end

  describe 'power state' do
    it 'defaults to an off power state' do
      expect(car.on_or_off).to eq('Off')
    end
  end

  describe 'seatbelt fastened' do
    it 'defaults to having the seatbelts disengaged' do
      is_expected.not_to be_seatbelt_fastened
    end
  end

  describe 'optional checks' do
    context 'before park' do
      before do
        car.on!
        car.fasten_seatbelts!
        car.drive!
        car.accelerate!
      end

      it 'does not let you park a moving car' do
        car.park!
        expect(car.current_state).to eq('Drive')
      end
    end

    context 'before drive' do
      it 'does not let the car drive until the seatbelt is fastened' do
        car.on!
        car.drive!
        expect(car.seatbelt_fastened?).to be_falsey
      end
    end

    context 'before turn on' do
      before do
        car.on!
        car.fasten_seatbelts!
        car.drive!
      end

      it 'can not turn on a driving car' do
        car.on!
        expect(car.current_state).to eq('Drive')
      end
    end
  end
end