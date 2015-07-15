class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.integer :post_category_id
      t.integer :user_id
      t.integer :postable_id
      t.string :postable_type
      t.attachment :attached_document

      t.timestamps
    end
  end
end
