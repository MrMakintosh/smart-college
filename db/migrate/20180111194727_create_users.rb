class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      ## auth info
      t.string   :login, unique: true
      t.string   :crypted_password
      t.string   :persistence_token

      ## admin point
      t.integer  :admin, default: 0, null: false
      t.integer  :superadmin, default: 0, null: false

      ## personal data
      t.string :name
      t.string :surname
      ## maybe add some more information like photo

      ## commercial data
      t.string :position ## strange column...need to do smth with that

      t.timestamps null: false
    end
  end
end
