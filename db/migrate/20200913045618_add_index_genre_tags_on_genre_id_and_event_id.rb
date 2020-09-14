class AddIndexGenreTagsOnGenreIdAndEventId < ActiveRecord::Migration[5.2]
  def change
    add_index :genre_tags, [:genre_id, :event_id], unique: true
  end
end
