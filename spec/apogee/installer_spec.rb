# frozen_string_literal: true

RSpec.describe Apogee::Installer do
  include_context 'with file manipulation'

  it 'validates the site_name' do
    expect {
      described_class.new('invalid site name here')
    }.to raise_error(Apogee::Installer::ApplicationNameInvalidError)
  end

  it 'validates the destination_dir' do
    allow(Dir).to receive(:exist?).with('abc/def').and_return(true)

    expect {
      described_class.new('def', destination_root_dir: 'abc')
    }.to raise_error(Apogee::Installer::InstallDirectoryAlreadyExistsError)
  end

  describe '#copy_template_files' do
    it 'copies the template files' do
      destination_root = File.join(temp_dir, 'copies_template_files')
      app_name = 'abc'
      install_path = File.join(destination_root, app_name)
      installer = described_class.new(app_name, destination_root_dir: destination_root)

      installer.copy_template_files

      expect(Dir.exist?(install_path)).to be true
      css_contents = IO.read(File.join(install_path, 'src', 'css', 'styles.css'))
      expect(css_contents).to eq "/* Your styles go here */\n"
    end
  end

  describe '#gsub_site_name' do
    it 'replaces the {{site_name}} token in the files with the site_name' do
      destination_root = File.join(temp_dir, 'replaces_site_name')
      app_name = 'abc'
      install_path = File.join(destination_root, app_name)
      installer = described_class.new(app_name, destination_root_dir: destination_root)
      installer.copy_template_files

      installer.gsub_site_name

      index_contents = IO.read(File.join(install_path, 'src', 'pages', 'index.html'))
      expect(index_contents).to eq "<h1>abc</h1>\n<p>Hello, World!</p>\n"
    end
  end
end
