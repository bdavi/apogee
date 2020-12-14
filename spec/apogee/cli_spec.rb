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

  describe '#build' do
    it 'builds the site' do
      builder = instance_double('Builder')
      cli = described_class.new

      allow(Apogee::Builder).to receive(:new).and_return(builder)
      expect(builder).to receive(:build)

      cli.build
    end
  end
end
