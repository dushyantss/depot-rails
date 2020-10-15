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
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with: /\.(gif|jpg|png)\Z/i,
    message: 'must be a URL for GIF, JPG or PNG image.',
  }
  # Callbacks
  # Other macros
end
