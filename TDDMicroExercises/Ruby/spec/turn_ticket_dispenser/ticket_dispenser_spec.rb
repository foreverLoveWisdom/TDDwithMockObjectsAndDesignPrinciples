# frozen_string_literal: true

require_relative '../../turn_ticket_dispenser/ticket_dispenser'
require 'pry-byebug'

RSpec.describe TicketDispenser do
  describe '#get_turn_ticket' do
    let(:ticket_dispenser) { TicketDispenser.new }
    let(:turn_number_sequence) { double('TurnNumberSequence') }
    let(:turn_ticket) { double('TurnTicket') }

    before do
      allow(turn_number_sequence).to receive(:get_next_turn_number).and_return(42)
      allow(turn_ticket).to receive(:new).with(42).and_return(:fake_turn_ticket)
    end

    it 'returns a new turn ticket with the correct turn number' do
      expect(ticket_dispenser.get_turn_ticket(turn_number_sequence, turn_ticket)).to eq :fake_turn_ticket
    end
  end
end
