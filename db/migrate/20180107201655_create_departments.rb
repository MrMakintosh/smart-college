class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|

      t.string :name, default:"Need to rename that :("

      t.timestamps null: false
    end
  end
end
