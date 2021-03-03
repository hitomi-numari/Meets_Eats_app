class AddRestaurantInfoToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :restaurant_name, :string, null:false, default:""
    add_column :events, :restaurant_img, :string, null:false, default:""
    add_column :events, :restaurant_access, :string, null:false, default:""
  end
end
