# frozen_string_literal: true

require 'yaml'
require_relative 'builder_helpers'

module Apogee
  # Processes site pages for distribution
  class PageRenderer
    include BuilderHelpers

    TOKEN_COMMENT_PATTERN = /\A<!--[\w\W]*-->/.freeze
    CSS_LINK_TAG = '<link rel="stylesheet" href="styles.css">'
    JS_SCRIPT_TAG = '<script src="script.js"></script>'

    attr_reader :page_content

    def render(page_content)
      @page_content = page_content

      tokens.inject(layout_content) do |rendered, (name, value)|
        rendered.gsub("{{#{name}}}", value)
      end
    end

    private

    def layout_content
      load_layout(tokens['layout'])
    end

    def tokens
      base_tokens.merge(parsed_tokens)
    end

    def base_tokens
      {
        'layout' => 'default',
        'css_bundle' => css_tag,
        'js_bundle' => js_tag,
        'page_content' => cleaned_page_content
      }
    end

    def parsed_tokens
      parse_tokens(page_content)
    end

    def parse_tokens(content)
      YAML.safe_load(
        content
          .match(TOKEN_COMMENT_PATTERN)[0]
          .delete_prefix('<!--').delete_suffix('-->')
          .each_line.map(&:strip).join("\n")
      )
    rescue StandardError
      {}
    end

    def css_tag
      css? ? CSS_LINK_TAG : ''
    end

    def js_tag
      js? ? JS_SCRIPT_TAG : ''
    end

    def cleaned_page_content
      page_content.gsub(TOKEN_COMMENT_PATTERN, '').strip
    end
  end
end
