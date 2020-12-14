# frozen_string_literal: true

module Apogee
  # Processes site css for distribution
  class CSSProcessor
    def css?
      file_paths.any?
    end

    def process
      return unless css?

      IO.write(out_path, processed_styles)
    end

    private

    def file_paths
      Dir[File.join('src', 'css', '**', '*.css')]
    end

    def processed_styles
      file_paths.map { |path| IO.read(path) }.join("\n")
    end

    def out_path
      File.join('dist', 'styles.css')
    end
  end
end
