class CreatePInformations < ActiveRecord::Migration[7.0]
  def change
    create_table :p_informations do |t|
      t.string :p_name,          null: false
      t.integer :category_id,    null: false
      t.float :amount,           null: false
      t.integer :standard_id,    null: false
      t.references :user,        null: false, foreign_key: true
      t.timestamps
    end
  end
end
