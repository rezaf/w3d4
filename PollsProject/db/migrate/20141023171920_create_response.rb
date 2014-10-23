class CreateResponse < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :answer_choice_id, presence: :true
      t.integer :responder_id, presence: :true
      
      t.timestamps
    end
    
    add_index(:responses, [:answer_choice_id], unique: :true)
  end
end
