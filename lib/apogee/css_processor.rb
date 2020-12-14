# frozen_string_literal: true

require_relative 'builder_helpers'

module Apogee
  # Processes site css for distribution
  class CSSProcessor
    include BuilderHelpers

    def process
      return unless css?

      IO.write(out_path, processed_styles)
    end

    private

    def processed_styles
      css_paths.map { |path| IO.read(path) }.join("\n")
    end

    def out_path
      File.join('dist', 'styles.css')
    end
  end
end
