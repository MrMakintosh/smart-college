class CreateSpecialties < ActiveRecord::Migration
  def change
    create_table :specialties do |t|

      t.string :name, default: "Need to rename that :("
      t.belongs_to :departments

      t.timestamps null: false
    end
  end
end
