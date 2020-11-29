class CreateEvaluations < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluations do |t|
      t.references :organizer, foreign_key: { to_table: :users }
      t.references :paticipant, foreign_key: { to_table: :users }
      t.integer :rate, null:false, default: 0

      t.timestamps
    end
    add_index :evaluations, [:organizer_id, :paticipant_id], unique: true
  end
end
