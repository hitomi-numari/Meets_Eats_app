class RemoveBudgetFromEventss < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :budget, :integer
  end
end
