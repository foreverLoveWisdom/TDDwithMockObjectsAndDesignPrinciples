# frozen_string_literal: true

require_relative '../../tire_pressure_monitoring_system/alarm'
require 'pry-byebug'

RSpec.describe Alarm do
  let(:sensor) { instance_double('sensor') }
  let(:alarm) { Alarm.new(sensor) }

  describe '#check' do
    context 'when pressure is below the low limit' do
      before do
        allow(sensor).to receive(:pop_next_pressure_psi_value).and_return(Alarm::LOW_PRESSURE - 1)
      end

      it 'turns on the alarm' do
        alarm.check
        expect(alarm.alarm_on).to eq(true)
      end
    end

    context 'when pressure is above the high limit' do
      before do
        allow(sensor).to receive(:pop_next_pressure_psi_value).and_return(Alarm::HIGH_PRESSURE + 1)
      end

      it 'turns on the alarm' do
        alarm.check
        expect(alarm.alarm_on).to eq(true)
      end
    end

    context 'when pressure is within the safe range' do
      before do
        allow(sensor).to receive(:pop_next_pressure_psi_value).and_return(Alarm::LOW_PRESSURE + 1)
      end

      it 'does not turn on the alarm' do
        alarm.check
        expect(alarm.alarm_on).to eq(false)
      end
    end
  end
end
