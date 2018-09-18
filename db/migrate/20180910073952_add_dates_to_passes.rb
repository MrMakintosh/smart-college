class AddDatesToPasses < ActiveRecord::Migration
  def change
    add_column :passes, :date_of, :date
    add_column :passes, :date_for, :date
  end
end
