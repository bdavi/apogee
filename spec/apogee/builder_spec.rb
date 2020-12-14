# frozen_string_literal: true

RSpec.describe Apogee::Builder do
  include_context 'with example site'

  describe '#build' do
    it 'runs each processor' do
      with_example_site('builder_runs_each_processor') do
        css_proceessor = instance_double('CSSProcessor')
        image_proceessor = instance_double('ImageProcessor')

        expect(css_proceessor).to receive(:process)
        expect(image_proceessor).to receive(:process)

        builder = described_class.new(processors: [css_proceessor, image_proceessor])
        builder.build
      end
    end

    it 'empties the `dist` directory before processing' do
      with_example_site('builder_empties_dist') do
        touch('dist', 'abc.txt')

        builder = described_class.new(processors: [])
        builder.build

        expect(file?('dist', 'abc.txt')).to be false
      end
    end
  end
end
