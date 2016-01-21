class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart

  def total_price
    line_item.price * quantity
  end
end
