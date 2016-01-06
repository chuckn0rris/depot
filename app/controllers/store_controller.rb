class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
    increment_counter
    @index_counter = get_counter

  end
end
