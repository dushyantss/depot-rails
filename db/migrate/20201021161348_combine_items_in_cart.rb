# frozen_string_literal: true
class CombineItemsInCart < ActiveRecord::Migration[6.0]
  def up
    # Replace multiple items for a single product in a cart with a single item
    Cart.find_each do |cart|
      sums = cart.line_items.group(:product_id).sum(:quantity)

      sums.each do |product_id, quantity|
        next if quantity <= 1

        # We delete every line_item except the first for a product
        cart.line_items.where(product_id: product_id).order(:id).offset(1).destroy_all

        # We update the remaining line_item's quantity
        cart.line_items.find_by(product_id: product_id).update!(quantity: quantity)
      end
    end
  end

  def down
    LineItem.where.not(quantity: 1).find_each do |item|
      (item.quantity - 1).times do
        LineItem.create!(product_id: item.product_id, cart_id: item.cart_id, quantity: 1)
      end
    end
  end
end
