class RenameLike < ActiveRecord::Migration[6.1]
  def change
    change_table :likes do |t|
      t.string :resources_like
      t.integer :resources_id
      t.remove :post_id
      t.remove :comment_id
      t.remove :type_like
    end
  end
end
