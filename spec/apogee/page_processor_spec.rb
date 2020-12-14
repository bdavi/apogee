# frozen_string_literal: true

RSpec.describe Apogee::PageProcessor do
  include_context 'with example site'

  describe '#process' do
    it 'renders the page in /dist' do
      renderer = Class.new do
        def self.render(string)
          "#{string}-xyz"
        end
      end

      with_example_site('process_pages') do
        make_file('src', 'pages', 'index.html', content: '123')
        mkdir('src', 'pages', 'abc')
        make_file('src', 'pages', 'abc', 'def.html', content: '456')

        described_class.new(renderer: renderer).process

        expect(file_contents('dist', 'index.html')).to eq '123-xyz'
        expect(file_contents('dist', 'abc', 'def.html')).to eq '456-xyz'
      end
    end
  end
end
