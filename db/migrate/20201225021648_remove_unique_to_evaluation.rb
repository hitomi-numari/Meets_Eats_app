class RemoveUniqueToEvaluation < ActiveRecord::Migration[5.2]
  def up
    remove_index :evaluations, [:organizer_id, :paticipant_id]
    add_index :evaluations, [:organizer_id, :paticipant_id]
  end

  def down
    remove_index :evaluations, [:organizer_id, :paticipant_id]
    add_index :evaluations, [:organizer_id, :paticipant_id], unique: true
  end
end
