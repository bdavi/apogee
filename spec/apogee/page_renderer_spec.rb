# frozen_string_literal: true

RSpec.describe Apogee::PageRenderer do
  include_context 'with example site'

  describe '#render' do
    context 'when no layout specified' do
      it 'renders the default layout' do
        page_content = '<p>abc</p>'
        with_example_site('render_with_default_layout') do
          make_file('src', 'layouts', 'default.html', content: '<html>{{page_content}}</html>')

          rendered = described_class.new.render(page_content)

          expect(rendered).to eq '<html><p>abc</p></html>'
        end
      end
    end

    context 'with a layout specified' do
      it 'renders the layout' do
        page_content = <<~HTML.strip
          <!-- layout: "no_nav" -->
          <p>def</p>
        HTML

        with_example_site('render_with_specific_layout') do
          make_file('src', 'layouts', 'no_nav.html', content: '<body>{{page_content}}</body>')

          rendered = described_class.new.render(page_content)

          expect(rendered).to eq '<body><p>def</p></body>'
        end
      end
    end

    context 'with an arbitrary token' do
      it 'renders the token' do
        page_content = <<~HTML.strip
          <!--
            title: "Hello, World"
            other_token: "abc"
          -->
          <p>def</p>
        HTML

        with_example_site('render_with_arbitrary_token') do
          make_file('src', 'layouts', 'default.html', content: <<~HTML)
            <html>
              <head>
                <title>{{title}}</title>
              </head>
              <body>
                <nav>{{other_token}}</nav>
                <main>{{page_content}}</main>
              </body>
            </html>
          HTML

          rendered = described_class.new.render(page_content)

          expect(rendered).to eq <<~HTML
            <html>
              <head>
                <title>Hello, World</title>
              </head>
              <body>
                <nav>abc</nav>
                <main><p>def</p></main>
              </body>
            </html>
          HTML
        end
      end
    end

    context 'with a css bundle' do
      it 'renders the css_bundle token' do
        page_content = '<p>abc</p>'

        with_example_site('render_with_css_bundle') do
          make_file('src', 'layouts', 'default.html', content: <<~HTML)
            <html>
              <head>{{css_bundle}}</head>
              <body>{{page_content}}</body>
            </html>
          HTML
          make_file('src', 'css', 'common.css', content: 'font-color: blue;')

          rendered = described_class.new.render(page_content)

          expect(rendered).to eq <<~HTML
            <html>
              <head><link rel="stylesheet" href="styles.css"></head>
              <body><p>abc</p></body>
            </html>
          HTML
        end
      end
    end

    context 'with no css' do
      it 'does not render the css_bundle token' do
        page_content = '<p>abc</p>'

        with_example_site('render_without_css') do
          make_file('src', 'layouts', 'default.html', content: <<~HTML)
            <html>
              <head>{{css_bundle}}</head>
              <body>{{page_content}}</body>
            </html>
          HTML

          rendered = described_class.new.render(page_content)

          expect(rendered).to eq <<~HTML
            <html>
              <head></head>
              <body><p>abc</p></body>
            </html>
          HTML
        end
      end
    end

    context 'with a js bundle' do
      it 'renders the js_bundle token' do
        page_content = '<p>abc</p>'

        with_example_site('render_with_js_bundle') do
          make_file('src', 'layouts', 'default.html', content: <<~HTML)
            <html>
              <head>{{js_bundle}}</head>
              <body>{{page_content}}</body>
            </html>
          HTML
          make_file('src', 'javascript', 'common.js', content: 'alert("hello")')

          rendered = described_class.new.render(page_content)

          expect(rendered).to eq <<~HTML
            <html>
              <head><script src="script.js"></script></head>
              <body><p>abc</p></body>
            </html>
          HTML
        end
      end
    end

    context 'with no js' do
      it 'does not render the js_bundle token' do
        page_content = '<p>abc</p>'

        with_example_site('render_without_js') do
          make_file('src', 'layouts', 'default.html', content: <<~HTML)
            <html>
              <head>{{js_bundle}}</head>
              <body>{{page_content}}</body>
            </html>
          HTML

          rendered = described_class.new.render(page_content)

          expect(rendered).to eq <<~HTML
            <html>
              <head></head>
              <body><p>abc</p></body>
            </html>
          HTML
        end
      end
    end
  end
end
