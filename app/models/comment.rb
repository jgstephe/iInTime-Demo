class Comment < ActiveRecord::Base
  attr_accessible :comment
  
  belongs_to :user_question_feedback
  
  validates :comment, :presence => true
  validates :user_question_feedback_id, :presence => true
  
  default_scope :order => 'comments.created_at DESC'
  
  scope :all_comments, lambda { |question| comments_on(question) }
  
  def get_user
    User.find_by_sql(%(SELECT name FROM users WHERE id = (SELECT user_id FROM user_question_feedbacks WHERE id = #{user_question_feedback.id} LIMIT 1)))[0]
  end
  
  def self.comments_on(q)
    uqf_ids = %(SELECT id FROM user_question_feedbacks WHERE question_id = :qid)
    where("user_question_feedback_id IN (#{uqf_ids})", { :qid => q })
  end
end
