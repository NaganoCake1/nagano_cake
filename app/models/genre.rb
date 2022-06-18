class Genre < ApplicationRecord
  belongs_to :item, optional: true
end
