class CreateProduct < ActiveRecord::Migration
  def up
    create_table :products do |t|
      t.string :name
      t.string :title_en
      t.string :title_ru
      t.integer :cost
      t.text :description_en
      t.text :description_ru
      t.integer :section_id

      t.integer :image_1_id
      t.integer :image_2_id
      t.integer :image_3_id
      t.integer :image_4_id
      t.integer :image_5_id
    end

    add_index :products, :name, :unique => true
  end

  def down
    drop_table :products
  end
end
