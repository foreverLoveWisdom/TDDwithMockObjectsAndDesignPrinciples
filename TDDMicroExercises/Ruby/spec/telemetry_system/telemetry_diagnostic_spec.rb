# frozen_string_literal: true

require_relative '../../telemetry_system/telemetry_diagnostic_controls'
require 'pry-byebug'

RSpec.describe TelemetryDiagnosticControls do
  subject(:telemetry_diagnostic_controls) { described_class.new }

  describe '#check_transmission' do
    let(:telemetry) { TelemetryClient }

    context 'when can connect to telemetry client' do
      let(:telemetry_client) { instance_double(telemetry, online_status: true, disconnect: true) }

      before do
        allow(telemetry).to receive(:new).and_return(telemetry_client)
        allow(telemetry_client).to receive(:send).with(TelemetryClient::DIAGNOSTIC_MESSAGE)
        allow(telemetry_client).to receive(:receive)
        telemetry_diagnostic_controls.check_transmission
      end

      it 'sends diagnostic message to telemetry client' do
        expect(telemetry_client).to have_received(:send).with(TelemetryClient::DIAGNOSTIC_MESSAGE)
      end

      it 'verifies teleclient receives diagnostic_info' do
        expect(telemetry_client).to have_received(:receive)
      end
    end

    context 'when cannot connect to telemetry client' do
      let(:telemetry_client) { instance_double(telemetry, disconnect: true) }

      before do
        allow(telemetry).to receive(:new).and_return(telemetry_client)
        allow(telemetry_client).to receive(:online_status).and_return(false)
        allow(telemetry_client).to receive(:connect).with(TelemetryDiagnosticControls::DIAGNOSTIC_CHANNEL_CONNECTION_STRING)
      end

      it 'raises an exception' do
        expect { telemetry_diagnostic_controls.check_transmission }.to raise_error(Exception, 'Unable to connect.')
      end
    end
  end
end
