class RemoveTitleFromSchedule < ActiveRecord::Migration[7.0]
  def change
    remove_column :schedules, :title, :string
  end
end
