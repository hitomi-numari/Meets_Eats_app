class ChangeColumnToNull < ActiveRecord::Migration[5.2]
  def up
    change_column_null :events, :budget, true, nil
    change_column :events, :budget, :integer, default: nil
    change_column_null :events, :check_in_time, true, nil
    change_column :events, :check_in_time, :integer, default: nil
  end

  def down
    change_column_null :events, :budget, false, 0
    change_column :events, :budget, :integer, default: 0
    change_column_null :events, :check_in_time, false, 0
    change_column :events, :check_in_time, :integer, default: 0
  end
end
