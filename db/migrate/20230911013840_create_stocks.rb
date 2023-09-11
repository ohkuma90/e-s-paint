class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.string :p_name,            null: false
      t.integer :category_id,         null: false
      t.string :color
      t.string :gloss
      t.integer :remaining_in_can, null: false
      t.integer :amount,           null: false
      t.integer :standard_id,         null: false
      t.text :remarks
      t.references :user,            null: false, foreign_key: true
      t.timestamps
    end
  end
end
