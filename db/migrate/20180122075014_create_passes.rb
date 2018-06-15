class CreatePasses < ActiveRecord::Migration
  def change
    create_table :passes do |t|
      t.date :date_of_pass, null: false
      t.string :lesson, default: "Не указано :("
      t.integer :hours, null:false, default: 2
      t.string :cause, default: "Не указано :("
      t.belongs_to :student

      t.timestamps null: false
    end
  end
end
