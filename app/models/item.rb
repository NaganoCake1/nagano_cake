class Item < ApplicationRecord

    has_one_attached :image

    has_many :cart_items
    has_many :order_details
    has_many :orders, through: :order_details
    belongs_to :genre

    def with_tax_price
     (price * 1.1).floor
    end

    validates :name, presence: true
    validates :introduction, presence: true
    validates :price, presence: true
    validates :is_active, presence: true
    validates :genre_id, presence: true

end
