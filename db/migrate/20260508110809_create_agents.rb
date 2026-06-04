class CreateAgents < ActiveRecord::Migration[8.1]
  def change
    create_table :agents do |t|
      t.string :codename, null: false
      t.integer :level, null: false
      t.boolean :active, null: false, default: true
      t.timestamps
    end

    add_index :agents, :codename, unique: true
    add_check_constraint :agents, 'level >= 1 AND level <= 10', name: 'level_range_check'
  end
end
