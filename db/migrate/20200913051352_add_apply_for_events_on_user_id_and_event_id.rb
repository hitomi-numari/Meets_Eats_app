class AddApplyForEventsOnUserIdAndEventId < ActiveRecord::Migration[5.2]
  def change
    add_index :apply_for_events, [:user_id, :event_id], unique: true
  end
end
