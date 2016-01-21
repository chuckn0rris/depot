class AddPriceToLineItems < ActiveRecord::Migration
  def up
    add_column :line_items, :price, :integer, default: 0

    LineItem.all do |line_item|
      product = Product.find_by_product_id(line_item.product_id)
      line_item.price = product.price
      line_item.save
    end
  end

  def down
    remove_column :line_items, :price, :integer
  end
end
