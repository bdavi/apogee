# frozen_string_literal: true

require 'fileutils'

RSpec.shared_context 'with example site' do
  include_context 'with file manipulation'

  def with_example_site(site_name)
    site_path = File.join(temp_dir, site_name)
    init_site(site_path)

    start_dir = Dir.pwd
    Dir.chdir(site_path)

    yield(site_path)

    Dir.chdir(start_dir)
  end

  def init_site(site_path)
    default_dir_paths(site_path).each do |dir_path|
      FileUtils.mkdir_p dir_path
    end
  end

  def default_dir_paths(site_path)
    [
      site_path,
      File.join(site_path, 'src'),
      File.join(site_path, 'src', 'images'),
      File.join(site_path, 'src', 'javascript'),
      File.join(site_path, 'src', 'css'),
      File.join(site_path, 'src', 'layouts'),
      File.join(site_path, 'src', 'pages'),
      File.join(site_path, 'dist')
    ]
  end
end
