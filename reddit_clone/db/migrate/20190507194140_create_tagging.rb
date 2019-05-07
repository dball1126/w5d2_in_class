class CreateTagging < ActiveRecord::Migration[5.2]
  def change
    create_table :taggings do |t|
      t.integer :post_id, null: false
      t.integer :sub_id, null: false

      t.timestamps
    end
    add_index :taggings, :post_id
    add_index :taggings, :sub_id
  end
end
