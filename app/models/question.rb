class Question < ActiveRecord::Base
  attr_accessible :content, :correct, :wrong, :title, :category, :expert_answer
  serialize :wrong, Hash
  
  has_many :user_question_feedbacks, :dependent => :destroy
  
  belongs_to :user
  
  # Must submit a question, a correct answer, and four decoy answers
  validates :content,  :presence => true
  validates :correct,  :presence => true, :length => { :maximum => 255 }
  validates :wrong,    :presence => true #, :length => { :minimum => 2 } # the token is automatically put in, so must have at least one other character
  validates :title,    :presence => true, :length => { :maximum => 255 }
  validates :category, :presence => true
  validates :user_id,  :presence => true
end
