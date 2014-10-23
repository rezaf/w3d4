class CreatePoll < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :title, presence: :true
      t.integer :author_id, presence: :true
      
      
      t.timestamps
      
    end
    
    add_index(:polls, [:author_id])
  end
end
