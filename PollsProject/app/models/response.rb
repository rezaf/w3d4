class Response < ActiveRecord::Base

  validates :answer_choice_id, :responder_id, presence: true
  validate :respondent_has_not_already_answered_question,
           :respondent_is_not_the_same_as_author
  
  belongs_to(
    :answer_choice,
    class_name: 'AnswerChoice',
    foreign_key: :answer_choice_id,
    primary_key: :id
  )
  
  belongs_to(
    :respondent,
    class_name: 'User',
    foreign_key: :responder_id,
    primary_key: :id
  )
  
  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )
  
  def poll
    question.poll
  end
  
  def sibling_responses 
    if self.persisted?
      self.question.responses.where('id IS NOT NULL AND responses.id != ?', @id)
    else
      self.question.responses
    end
  end
  
  def respondent_has_not_already_answered_question
    unless self.sibling_responses.where(:responder_id => self.responder_id).empty?
      errors[:response] << "Can't respond twice"
    end
  end
  
  def respondent_is_not_the_same_as_author
    if poll.author_id == self.responder_id
      errors[:response] << "Author cannot answer their own poll!!"
    end
  end
  
end