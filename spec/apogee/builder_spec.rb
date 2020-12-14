# frozen_string_literal: true

RSpec.describe Apogee::Builder do
  describe '#build' do
    it 'runs each processor' do
      css_proceessor = instance_double('CSSProcessor')
      image_proceessor = instance_double('ImageProcessor')

      expect(css_proceessor).to receive(:process)
      expect(image_proceessor).to receive(:process)

      builder = described_class.new(processors: [css_proceessor, image_proceessor])

      builder.build
    end
  end
end
