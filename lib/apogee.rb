# frozen_string_literal: true

require 'apogee/version'
require 'apogee/installer'
require 'apogee/file_helpers'
require 'apogee/cli'
require 'apogee/image_processor'
require 'apogee/css_processor'
require 'apogee/js_processor'
require 'apogee/page_processor'
require 'apogee/builder_helpers'

module Apogee
  class Error < StandardError; end
end
