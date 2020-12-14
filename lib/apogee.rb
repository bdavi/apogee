# frozen_string_literal: true

require 'apogee/version'
require 'apogee/installer'
require 'apogee/file_helpers'
require 'apogee/cli'
require 'apogee/image_processor'
require 'apogee/css_processor'
require 'apogee/js_processor'

module Apogee
  class Error < StandardError; end
end
