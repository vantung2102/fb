class AddGroupUser < ActiveRecord::Migration[6.1]
  def change
    create_table :group_users do |t|
      t.references :users 
      t.references :groups

      t.timestamps
    end
  end
end
