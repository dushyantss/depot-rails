# frozen_string_literal: true
class Cart < ApplicationRecord
  # Default scope
  # Constants
  # Attr macros
  # Enums
  # Association
  has_many :line_items, dependent: :destroy
  # Validations
  # Callbacks
  # Other macros
end
