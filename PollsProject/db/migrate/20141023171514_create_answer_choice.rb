class CreateAnswerChoice < ActiveRecord::Migration
  def change
    create_table :answer_choices do |t|
      t.string :text, presence: :true
      t.integer :question_id, presence: :true
      
      t.timestamps
    end
    
    add_index(:answer_choices, [:question_id]) #we may want to add unique later
  end
end
