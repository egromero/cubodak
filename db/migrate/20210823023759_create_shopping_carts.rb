class CreateShoppingCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :shopping_carts do |t|
      t.decimal :total_price
      t.belongs_to :user
      t.timestamps
    end
  end
end
