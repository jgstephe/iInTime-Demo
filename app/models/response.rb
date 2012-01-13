class Response < ActiveRecord::Base
  attr_accessible :content
  
  belongs_to :user_question_feedback
  
  validates :content, :presence => true
  validates :user_question_feedback_id, :presence => true
  
  def correct?
    content.downcase == user_question_feedback.question.correct.downcase
  end
end
