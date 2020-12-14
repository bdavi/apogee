# frozen_string_literal: true

require 'fileutils'

RSpec.shared_context 'with file manipulation' do
  before(:all) do
    FileUtils.rm_rf(temp_dir)
    FileUtils.mkdir(temp_dir)
  end

  after(:all) do
    FileUtils.rm_rf(temp_dir)
  end

  def temp_dir
    File.join(Dir.pwd, 'spec', 'tmp')
  end
end
