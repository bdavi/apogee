# frozen_string_literal: true

module Apogee
  # Processes site images for distribution
  class ImageProcessor
    def images?
      Dir[File.join('src', 'images', '**', '*.*')].any?
    end

    def process
      return unless images?

      FileUtils.cp_r(File.join('src', 'images'), File.join('dist', 'images'))
    end
  end
end
