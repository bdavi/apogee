# frozen_string_literal: true

RSpec.describe Apogee::FileHelpers do
  include_context 'with file manipulation'

  describe '.file_gsub' do
    it 'applies gsub to the file contents' do
      path = File.join(temp_dir, 'temp.txt')
      IO.write(path, '<p>{{to_replace}}</p>')

      described_module.file_gsub(path, '{{to_replace}}', 'abc123')

      expect(IO.read(path)).to eq '<p>abc123</p>'
    end
  end
end
