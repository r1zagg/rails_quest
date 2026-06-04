class CreateMissions < ActiveRecord::Migration[8.1]
  def change
    create_table :missions do |t|
      t.references :agent, null: false, foreign_key: true
      t.string :title, null: false
      t.string :status, null: false   # НЕТ default!
      t.timestamps
    end

    add_check_constraint :missions, "status IN ('assigned', 'in_progress', 'completed')", name: 'mission_status_check'
  end
end
