class Item < ApplicationRecord

has_one_attached :iamge

has_many :genres
belongs_to :user

end
