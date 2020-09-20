class AddExpiredTimeToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :expired_time, :datetime
  end
end
