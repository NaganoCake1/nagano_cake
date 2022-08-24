class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }

  enum status: {
    waiting:0,#"入金待ち"
    paid_check:1,#"入金確認"
    creating:2,#"製作中"
    preparing:3,#"発送準備中"
    shipped:4#"発送済み"
  }

  belongs_to :customer
  has_many :order_details
  has_many :items, through: :order_details
  
  
  
end
