class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|

      t.string :name, default: "-"
      t.string :surname, default: "-"
      t.string :fathername, default: "-"
      t.string :birthday, default: "-"
      t.string :adress, default: "-"

      t.timestamps null: false
    end
  end
end
