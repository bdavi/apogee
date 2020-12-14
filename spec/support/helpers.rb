# frozen_string_literal: true

module RSpecHelpers
  def described_module
    return described_class if described_class.is_a? Module

    nil
  end
end
