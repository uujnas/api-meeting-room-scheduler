class RemoveReferencesFromSchedule < ActiveRecord::Migration[7.0]
  def change
    remove_reference :schedules, :room, null: false, foreign_key: true
  end
end
