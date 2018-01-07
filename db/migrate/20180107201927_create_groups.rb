class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|

      t.string :number, default: "Need to rename that :("
      t.belongs_to :specialty

      t.timestamps null: false
    end
  end
end
