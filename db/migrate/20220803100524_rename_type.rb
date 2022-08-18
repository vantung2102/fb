class RenameType < ActiveRecord::Migration[6.1]
  def change
    change_table :likes do |t|
      t.rename :type, :type_like
    end
  end
end
