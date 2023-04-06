# frozen_string_literal: true

require_relative './sensor'

# Alarm logic
class Alarm
  attr_reader :alarm_on

  LOW_PRESSURE = 17
  HIGH_PRESSURE = 21
  PRESSURE_RANGE = (LOW_PRESSURE..HIGH_PRESSURE)

  def initialize
    @alarm_on = false
  end

  def check(sensor = Sensor.new)
    return if valid_pressure?(sensor.pop_next_pressure_psi_value)

    turn_on_alarm
  end

  private

  attr_reader :sensor
  attr_writer :alarm_on

  def turn_on_alarm
    self.alarm_on = true
  end

  def pressure_value
    sensor.pop_next_pressure_psi_value
  end

  def valid_pressure?(pressure)
    PRESSURE_RANGE.cover?(pressure)
  end
end
