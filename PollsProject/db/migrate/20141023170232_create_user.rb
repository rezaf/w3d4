class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, unique: :true, presence: :true
      
      t.timestamps
      
    end
  end
end
