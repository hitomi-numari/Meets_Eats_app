class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :nickname, null:false, default:""
      t.string :icon, null:false, default:""
      t.date :birthday, null:false
      t.integer :gender, null:false, default:0
      t.string :instagram_url, null:false, default:""
      t.string :facebook_url, null:false, default:""
      t.text :details, null:false

      t.timestamps
    end
  end
end
