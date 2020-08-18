class CreateAreaTags < ActiveRecord::Migration[5.2]
  def change
    create_table :area_tags do |t|
      t.references :area, foreign_key: true
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
