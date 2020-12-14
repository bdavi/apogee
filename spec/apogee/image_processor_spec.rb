# frozen_string_literal: true

RSpec.describe Apogee::ImageProcessor do
  include_context 'with example site'

  describe '#images?' do
    context 'when there are images' do
      it 'returns true' do
        with_example_site('has_images') do
          touch('src', 'images', 'abc.jpg')

          expect(described_class.new.images?).to be true
        end
      end
    end

    context 'when there are images in nested folders' do
      it 'returns true' do
        with_example_site('has_nested_images') do
          mkdir('src', 'images', 'abc')
          touch('src', 'images', 'abc', 'def.png')

          expect(described_class.new.images?).to be true
        end
      end
    end

    context 'when there are no images' do
      it 'returns false' do
        with_example_site('no_images') do
          expect(described_class.new.images?).to be false
        end
      end
    end
  end

  describe '#process' do
    context 'when there are no images' do
      it 'does not make dist/images' do
        with_example_site('process_no_images') do
          described_class.new.process

          expect(dir?('dist', 'images')).to be false
        end
      end
    end

    context 'when there are images' do
      it 'copies over the src/images folder to dist' do
        with_example_site('process_with_images') do
          mkdir('src', 'images', 'abc')
          touch('src', 'images', 'abc', 'def.png')

          described_class.new.process

          expect(dir?('dist', 'images')).to be true
          expect(dir?('dist', 'images', 'abc')).to be true
          expect(file?('dist', 'images', 'abc', 'def.png')).to be true
        end
      end
    end
  end
end
