# frozen_string_literal: true

RSpec.describe Apogee::CSSProcessor do
  include_context 'with example site'

  describe '#css?' do
    context 'when there is css' do
      it 'returns true' do
        with_example_site('has_css') do
          touch('src', 'css', 'abc.css')

          expect(described_class.new.css?).to be true
        end
      end
    end

    context 'when there is css in nested folders' do
      it 'returns true' do
        with_example_site('has_nested_css') do
          mkdir('src', 'css', 'abc')
          touch('src', 'css', 'abc', 'def.css')

          expect(described_class.new.css?).to be true
        end
      end
    end

    context 'when there is no css' do
      it 'returns false' do
        with_example_site('no_css') do
          expect(described_class.new.css?).to be false
        end
      end
    end
  end

  describe '#process' do
    context 'when there is no css' do
      it 'does not make dist/styles.css' do
        with_example_site('process_no_css') do
          described_class.new.process

          expect(file?('dist', 'styles.css')).to be false
        end
      end
    end

    context 'when there is css' do
      it 'concatenates the css into dist/styles.css' do
        with_example_site('process_with_css') do
          make_file('src', 'css', 'abc.css', content: '123')
          mkdir('src', 'css', 'def')
          make_file('src', 'css', 'def', 'ghi.css', content: '456')

          described_class.new.process

          expect(file_contents('dist', 'styles.css')).to eq "123\n456"
        end
      end
    end
  end
end
