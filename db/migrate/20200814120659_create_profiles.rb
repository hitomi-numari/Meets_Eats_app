class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :nickname
      t.string :icon
      t.date :birthday
      t.integer :gender
      t.string :instagram_url
      t.string :facebook_url
      t.text :details
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
