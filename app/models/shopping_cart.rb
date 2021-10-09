class ShoppingCart < ApplicationRecord
    has_many :shopping_cart_product
    has_many :products, through: :shopping_cart_product
    belongs_to :user, optional: true
end
