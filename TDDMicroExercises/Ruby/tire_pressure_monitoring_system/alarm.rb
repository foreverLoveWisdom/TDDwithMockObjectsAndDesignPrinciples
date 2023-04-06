# frozen_string_literal: true

require_relative './sensor'

# Alarm logic
class Alarm
  attr_reader :alarm_on

  LOW_PRESSURE = 17
  HIGH_PRESSURE = 21

  def initialize(sensor = Sensor.new)
    @sensor = sensor
    @alarm_on = false
  end

  def check
    @alarm_on = true unless valid_pressure?(pressure_value)
  end

  private

  attr_reader :sensor

  def pressure_value
    sensor.pop_next_pressure_psi_value
  end

  def valid_pressure?(pressure)
    pressure >= LOW_PRESSURE && pressure <= HIGH_PRESSURE
  end
end
