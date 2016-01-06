class Product < ActiveRecord::Base
  has_many :line_items

  before_destroy :ensure_not_references_by_any_line_item

  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
      with: %r{\.(gif|jpeg|jpg|png)$}i,
      # NOTE: not sure why it doesn't works in this ruby version
      # ERROR: ArgumentError: The provided regular expression is using multiline anchors (^ or $),
      # which may present a security risk. Did you mean to use \A and \z,
      # or forgot to add the :multiline => true option?
      multiline: true,
      message: 'URL должен указывать на изображение.'
  }
  validates :title, length: {minimum: 10, too_short: "Title should contains more than 10 simbols"}

  private

  def ensure_not_references_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'существуют товарные позиции')
      return false
    end
  end

end
