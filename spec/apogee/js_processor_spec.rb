# frozen_string_literal: true

RSpec.describe Apogee::JSProcessor do
  include_context 'with example site'

  describe '#js?' do
    context 'when there is js' do
      it 'returns true' do
        with_example_site('has_js') do
          touch('src', 'javascript', 'abc.js')

          expect(described_class.new.js?).to be true
        end
      end
    end

    context 'when there is js in nested folders' do
      it 'returns true' do
        with_example_site('has_nested_js') do
          mkdir('src', 'javascript', 'abc')
          touch('src', 'javascript', 'abc', 'def.js')

          expect(described_class.new.js?).to be true
        end
      end
    end

    context 'when there is no js' do
      it 'returns false' do
        with_example_site('no_js') do
          expect(described_class.new.js?).to be false
        end
      end
    end
  end

  describe '#process' do
    context 'when there is no js' do
      it 'does not make dist/script.js' do
        with_example_site('process_no_js') do
          described_class.new.process

          expect(file?('dist', 'script.js')).to be false
        end
      end
    end

    context 'when there is js' do
      it 'concatenates the js into dist/script.js' do
        with_example_site('process_with_js') do
          make_file('src', 'javascript', 'abc.js', content: '123')
          mkdir('src', 'javascript', 'def')
          make_file('src', 'javascript', 'def', 'ghi.js', content: '456')

          described_class.new.process

          expect(file_contents('dist', 'script.js')).to eq "123\n456"
        end
      end
    end
  end
end
