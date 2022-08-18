class AddLikeAble < ActiveRecord::Migration[6.1]
  def change
    change_table :likes do |t|
      t.references :likeable, polymorphic: true, null: false
    end
  end
end
