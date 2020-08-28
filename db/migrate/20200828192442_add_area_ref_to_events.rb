class AddAreaRefToEvents < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :area, foreign_key: true
  end
end
