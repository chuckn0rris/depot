class CopyPriceFromProductToLineItem < ActiveRecord::Migration
  def up
    LineItem.all do |line_item|
      product = Product.find_by_product_id(line_item.product_id)
      line_item.price = product.price
      line_item.save
    end
  end

  def down
    LineItem.all do |line_item|
      line_item.price = 0
      line_item.save
    end
  end
end
