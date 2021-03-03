class AddBudgetToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :budget, :string, null:false, default: ""
  end
end
