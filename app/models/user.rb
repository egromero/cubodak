class User < ApplicationRecord
    has_many :products
    has_one :shopping_cart
end
