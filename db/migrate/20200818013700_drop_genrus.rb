class DropGenrus < ActiveRecord::Migration[5.2]
  def change
    drop_table :genrus
  end
end
