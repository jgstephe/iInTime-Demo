class Rating < ActiveRecord::Base
  attr_accessible :rating
  
  belongs_to :user_question_feedback
  
  validates :rating, :presence => true
  validates :user_question_feedback_id, :presence => true
  
  def self.average_rating(qid)
    ratings = where("user_question_feedback_id IN (" +
            select("id").from("user_question_feedbacks").where("question_id = #{qid.id}").to_sql + ")")
    ratings.any? ? ratings.average("rating").round(2) : 0.00
  end
  
end
