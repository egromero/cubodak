class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.belongs_to :user, index: true, foreign_key: true
      t.string :description
      t.string :final_price
      t.timestamps
    end
  end
end
