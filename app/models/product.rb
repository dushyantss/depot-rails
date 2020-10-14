# frozen_string_literal: true
class Product < ApplicationRecord
  # Default scope
  # Constants
  # Attr macros
  # Enums
  # Association
  # Validations
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  # Callbacks
  # Other macros
end
