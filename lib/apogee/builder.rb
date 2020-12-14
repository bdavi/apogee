# frozen_string_literal: true

require_relative 'builder_helpers'

module Apogee
  # Builds site for distribution using the specified processors
  class Builder
    attr_reader :processors

    def initialize(
      processors: [
        ImageProcessor.new,
        CSSProcessor.new,
        JSProcessor.new,
        PageProcessor.new
      ]
    )
      @processors = processors
    end

    def build
      processors.each(&:process)
    end
  end
end
