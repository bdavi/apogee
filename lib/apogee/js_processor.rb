# frozen_string_literal: true

require_relative 'builder_helpers'

module Apogee
  # Processes site js for distribution
  class JSProcessor
    include BuilderHelpers

    def process
      return unless js?

      IO.write(out_path, processed_js)
    end

    private

    def processed_js
      js_paths.map { |path| IO.read(path) }.join("\n")
    end

    def out_path
      File.join('dist', 'scripts.js')
    end
  end
end
