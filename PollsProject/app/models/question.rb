class Question < ActiveRecord::Base
  
  validates :text, :poll_id, presence: true
  
  belongs_to(
    :poll,
    class_name: 'Poll',
    foreign_key: :poll_id,
    primary_key: :id
  )
  
  has_many(
    :answer_choices,
    class_name: 'AnswerChoice',
    foreign_key: :question_id,
    primary_key: :id
  )
  
  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )
  
  def results
    result = Hash.new(0)
    answer_choices = self.answer_choices.includes(:responses)
   
    answer_choices.each do |an_c|
      result[an_c.text] = an_c.responses.length
    end
    
    result
  end
  
end