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
  
  # def results
  #   result = Hash.new(0)
  #   answer_choices = self.answer_choices.includes(:responses)
  #
  #   answer_choices.each do |an_c|
  #     result[an_c.text] = an_c.responses.length
  #   end
  #
  #   result
  # end
  
  # def results
  #  answer_choices = AnswerChoice.find_by_sql([
  #     "SELECT
  #       answer_choices.*, COUNT(*) AS response_count
  #     FROM
  #       answer_choices
  #     LEFT OUTER JOIN
  #       responses
  #     ON
  #       answer_choices.id = responses.answer_choice_id
  #     WHERE
  #       answer_choices.question_id = ?
  #     GROUP BY
  #       answer_choice_id", self.id
  #   ])
  #
  #   counts = Hash.new(0)
  #
  #   answer_choices.each do |ans_c|
  #     counts[ans_c.text] = ans_c.response_count
  #   end
  #
  #   # p answer_choices
  #   # p counts
  #   counts
  # end
  #
  def results
    ok = AnswerChoice.select(self.answer_choices).joins(
      "LEFT OUTER JOIN 
      responses 
      ON answer_choices.id = responses.answer_choice_id"
    ).where('self.answer_choices.question_id = ?', self.id
    )
    
    p ok
    
  end
  
end