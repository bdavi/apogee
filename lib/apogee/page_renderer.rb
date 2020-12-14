# frozen_string_literal: true

require 'yaml'
require_relative 'builder_helpers'

module Apogee
  # Processes site pages for distribution
  class PageRenderer
    include BuilderHelpers

    TOKEN_COMMENT_PATTERN = /\A<!--[^>]*-->/.freeze

    attr_reader :page_content

    def render(page_content)
      @page_content = page_content

      tokens.inject(layout_content) do |rendered, (name, value)|
        rendered.gsub("{{#{name}}}", value)
      end
    end

    def layout_content
      layout(tokens['layout'])
    end

    def tokens
      automatic_tokens.merge(parsed_tokens)
    end

    def automatic_tokens
      {
        'layout' => 'default',
        'css_bundle' => css_bundle,
        'js_bundle' => js_bundle,
        'page_content' => cleaned_page_content
      }
    end

    def parsed_tokens
      doc = page_content
              .match(TOKEN_COMMENT_PATTERN)[0]
              .delete_prefix('<!--')
              .delete_suffix('-->')
              .each_line
              .map(&:strip)
              .join("\n")

      YAML.safe_load(doc)
    rescue StandardError
      {}
    end

    def css_bundle
      return '' unless css?

      '<link rel="stylesheet" href="styles.css">'
    end

    def js_bundle
      return '' unless js?

      '<script src="script.js"></script>'
    end

    def cleaned_page_content
      page_content.gsub(TOKEN_COMMENT_PATTERN, '').strip
    end
  end
end
