class AddIndexApplyForEventOnUserIdAndEventId < ActiveRecord::Migration[5.2]
  def change
    add_index :apply_for_events, [:event_id, :user_id], unique: true
  end
end
