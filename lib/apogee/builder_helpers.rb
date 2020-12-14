# frozen_string_literal: true

module Apogee
  # Helpers for classes processing the build
  module BuilderHelpers
    def images?
      image_paths.any?
    end

    def image_paths
      Dir[File.join('src', 'images', '**', '*.*')]
    end

    def css?
      css_paths.any?
    end

    def css_paths
      Dir[File.join('src', 'css', '**', '*.css')]
    end

    def js?
      js_paths.any?
    end

    def js_paths
      Dir[File.join('src', 'javascript', '**', '*.js')]
    end
  end
end
