# frozen_string_literal: true
require_relative './turn_number_sequence'
require_relative './turn_ticket'

# This class is responsible for dispensing turn tickets
class TicketDispenser
  def get_turn_ticket(turn_number_sequence = TurnNumberSequence.new, turn_ticket = TurnTicket)
    new_turn_number = turn_number_sequence.get_next_turn_number

    turn_ticket.new(new_turn_number)
  end
end
