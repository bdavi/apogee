# frozen_string_literal: true

RSpec.describe Apogee::CLI do
  describe '#new' do
    it 'creates a new site' do
      installer = instance_double('Installer')
      cli = described_class.new

      allow(Apogee::Installer).to receive(:new).with('abc123').and_return(installer)
      expect(installer).to receive(:install)

      cli.new('abc123')
    end
  end
end
