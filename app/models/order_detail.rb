class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum making_status: {
    making_impossible:0,#"制作不可"
    making_wait:1,#"制作待ち"
    making:2,#"製作中"
    making_complete:3#"制作完了"
  }

end
