class DropGenruTags < ActiveRecord::Migration[5.2]
  def change
    drop_table :genru_tags
  end
end
