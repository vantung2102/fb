class RenameLikeAble < ActiveRecord::Migration[6.1]
  def change
    change_table :likes do |t|
      t.rename :resources_like, :likeable_type
      t.rename :resources_id, :likeable_id
    end
  end
end
