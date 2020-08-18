class AddFoodCategoryToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :food_category, :integer, null:false, default: "0"
  end
end
