class AddUniqueToUserIdForApplyForEvents < ActiveRecord::Migration[5.2]
  def change
    remove_index :apply_for_events, [:user_id]
    add_index :apply_for_events, [:user_id], :unique => true
  end
end
