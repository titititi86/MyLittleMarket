class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title,  null: false
      t.text :description
      t.float :price,  null: false

      t.timestamps null: false
    end
    add_reference :products, :user, foreign_key: true
    add_index :products, [:user_id, :created_at]
  end
end
