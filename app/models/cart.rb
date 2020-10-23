# frozen_string_literal: true

# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
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

  # @param [Product] product
  def add_product(product)
    # @type [LineItem, NilClass]
    item = line_items.find_by(product: product)
    if item.present?
      item.quantity += 1
    else
      item = line_items.build(product: product)
    end

    item
  end

  def total_price
    line_items.to_a.sum(&:total_price)
  end
end
