# frozen_string_literal: true

require_relative 'file_helpers'

module Apogee
  # Creates an empty apogee site
  class Installer
    VALID_FILENAME_PATTERN = /\A[A-Za-z0-9-_]+\z/.freeze
    FILES_WITH_SITE_NAME = [
      'README.md',
      File.join('src', 'pages', 'index.html')
    ].freeze

    attr_reader :site_name, :destination_root_dir

    def initialize(site_name, destination_root_dir: Dir.pwd)
      @site_name = site_name
      @destination_root_dir = destination_root_dir
      validate
    end

    def install
      copy_template_files
      gsub_site_name
    end

    def gsub_site_name
      FILES_WITH_SITE_NAME.each do |file|
        path = File.join(destination_dir, file)
        FileHelpers.file_gsub(path, '{{site_name}}', site_name)
      end
    end

    private

    def copy_template_files
      FileUtils.mkdir_p(destination_root_dir) unless Dir.exist?(destination_root_dir)
      FileUtils.cp_r(template_dir, destination_dir)
    end

    def validate
      validate_destination_dir
      validate_site_name
    end

    def validate_destination_dir
      return unless Dir.exist?(destination_dir)

      raise InstallDirectoryAlreadyExistsError, "#{destination_dir} already exists."
    end

    def validate_site_name
      return if site_name.match?(VALID_FILENAME_PATTERN)

      raise ApplicationNameInvalidError, \
            "#{site_name} is not a valid site name. Please use only " \
            'letters, numbers, underscores and dashes in the application name'
    end

    def destination_dir
      File.join(destination_root_dir, site_name)
    end

    def template_dir
      File.join(File.dirname(__FILE__), 'templates', 'new_site')
    end

    class InstallDirectoryAlreadyExistsError < StandardError; end
    class ApplicationNameInvalidError < StandardError; end
  end
end
