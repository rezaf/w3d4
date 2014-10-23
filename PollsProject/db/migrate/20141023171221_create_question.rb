class CreateQuestion < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :text, presence: :true
      t.integer :poll_id, presence: :true    
      
      t.timestamps
    end
    
    add_index(:questions, [:poll_id])
  end
end
