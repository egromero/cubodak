class CreateShoppingCartProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :shopping_cart_products do |t|
      t.belongs_to :product
      t.belongs_to :shopping_cart
      t.integer :quantity
      t.timestamps
    end
  end
end
