# frozen_string_literal: true

module Apogee
  # Helpers related to files and file manipulation
  module FileHelpers
    def self.file_gsub(path, pattern, replacement)
      IO.write(
        path,
        IO.read(path).gsub(pattern, replacement)
      )
    end
  end
end
