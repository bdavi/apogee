# frozen_string_literal: true

require_relative 'lib/apogee/version'

Gem::Specification.new do |spec|
  spec.name          = 'apogee'
  spec.version       = Apogee::VERSION
  spec.authors       = ['Brian Davies']
  spec.email         = ['brian@disjunct.io']

  spec.summary       = 'Apogee is a static site generator for people in a hurry.'
  spec.description   = 'Apogee is a static site generator for people in a hurry. ' \
                          "Sometimes you just don't need the hassle of a full framework"
  spec.homepage      = 'https://github.com/bdavi/apogee'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.6.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/bdavi/apogee'
  spec.metadata['changelog_uri'] = 'https://github.com/bdavi/apogee/blob/main/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = 'exe'
  spec.executables << 'apogee'
  spec.require_paths = ['lib']
end
