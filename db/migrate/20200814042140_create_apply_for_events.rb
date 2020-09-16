class CreateApplyForEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :apply_for_events do |t|
      t.references :user, foreign_key: true, unique:true
      t.references :event, foreign_key: true
      t.integer :status, null:false, default:"0"

      t.timestamps
    end
  end
end
