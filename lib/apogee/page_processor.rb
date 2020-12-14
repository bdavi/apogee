# frozen_string_literal: true

require_relative 'builder_helpers'

module Apogee
  # Processes site pages for distribution
  class PageProcessor
    attr_reader :renderer

    def initialize(renderer: PageRenderer.new)
      @renderer = renderer
    end

    def process
      copy_src_pages_to_dist

      dist_file_paths.each do |path|
        IO.write(
          path,
          renderer.render(IO.read(path))
        )
      end
    end

    private

    def copy_src_pages_to_dist
      FileUtils.cp_r(File.join('src', 'pages', '.'), 'dist')
    end

    def dist_file_paths
      Dir[File.join('dist', '**', '*.html')]
    end
  end
end
