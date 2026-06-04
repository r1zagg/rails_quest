class CreateSkills < ActiveRecord::Migration[8.1]
  def change
    create_table :skills do |t|
      t.string :name, null: false
      t.string :category, null: false   # сделали обязательным на уровне БД (опционально)
      t.timestamps
    end

    add_index :skills, :name, unique: true
  end
end
