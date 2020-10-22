# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  description :text
#  image_url   :string
#  price       :decimal(8, 2)
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Product < ApplicationRecord
  # Default scope
  # Constants
  # Attr macros
  # Enums
  # Association
  has_many :line_items
  # Validations
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with: /\.(gif|jpg|png)\Z/i,
    message: 'must be a URL for GIF, JPG or PNG image.',
  }
  # Callbacks
  before_destroy :ensure_not_referenced_by_any_line_item
  # Other macros

  private

  # ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    if line_items.present?
      errors.add(:base, 'Line Items present')
      throw :abort
    end
  end
end
