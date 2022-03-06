class CreateMeetings < ActiveRecord::Migration[7.0]
  def change
    create_table :meetings do |t|
      t.string :subject
      t.text :members, array: true, default: []
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
