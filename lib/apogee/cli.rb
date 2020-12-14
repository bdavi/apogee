# frozen_string_literal: true

require 'thor'

module Apogee
  # Command line interface
  class CLI < Thor
    package_name 'apogee'

    desc 'new SITE_NAME', 'Creates a new empty site.'
    long_desc <<~LONGDESC
      `apogee new SITE_NAME` will create a new empty site with the specified name.

      SITE_NAME must be a valid as a directory name and contain only letters, numbers, dashes and underscores.

      Example:
      \x5> apogee new site_name
    LONGDESC
    def new(site_name)
      Installer.new(site_name).install
    end

    desc 'build', 'Builds the site for preview or distribution'
    long_desc <<~LONGDESC
      `apogee build` will builds the site for preview or distribution.

      WARNING: THIS WILL OVERWRITE THE CONTENTS OF THE `/dist` DIRECTORY.

      The working files in `/src` are compiled into `/dist`.

      Example:
      \x5> apogee build
    LONGDESC
    def build
      Builder.new.build
    end
  end
end
