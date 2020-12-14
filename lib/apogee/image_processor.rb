# frozen_string_literal: true

require_relative 'builder_helpers'

module Apogee
  # Processes site images for distribution
  class ImageProcessor
    include Apogee::BuilderHelpers

    def process
      return unless images?

      FileUtils.cp_r(File.join('src', 'images'), File.join('dist', 'images'))
    end
  end
end
