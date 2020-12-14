# frozen_string_literal: true

module Apogee
  # Processes site js for distribution
  class JSProcessor
    def js?
      file_paths.any?
    end

    def process
      return unless js?

      IO.write(out_path, processed_js)
    end

    private

    def file_paths
      Dir[File.join('src', 'javascript', '**', '*.js')]
    end

    def processed_js
      file_paths.map { |path| IO.read(path) }.join("\n")
    end

    def out_path
      File.join('dist', 'scripts.js')
    end
  end
end
