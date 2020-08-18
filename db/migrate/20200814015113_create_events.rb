class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title, null:false, default:""
      t.text :content, null:false, default:""
      t.string :restaurant_url, null:false, default:""
      t.integer :budget, null:false, default: 0
      t.datetime :start_at
      t.datetime :end_at
      t.integer :check_in_time, null:false, default: 0

      t.timestamps
    end
  end
end
