class UserQuestionFeedback < ActiveRecord::Base
  attr_accessible :question_id
  
  belongs_to :user
  belongs_to :question
  
  validates :user_id, :presence => true
  validates :question_id, :presence => true
  
  has_many :responses
  has_many :ratings
  has_many :comments
end
