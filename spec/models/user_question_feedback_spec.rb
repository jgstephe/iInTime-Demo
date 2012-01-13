require 'spec_helper'

describe UserQuestionFeedback do
  before :each do
    @u = Factory :user
    @q = Factory(:question, :created_by => @u)
    #test_sign_in(@u)
  end
  
  it "should require a user id" do
    UserQuestionFeedback.new(:question_id => @q).should_not be_valid
  end
  
  it "should require a question id" do
    UserQuestionFeedback.new(:user_id => @u).should_not be_valid
  end
  
  it "should create a new feedback given proper attributes" do
    lambda do
      @u.user_question_feedbacks.create!(:question_id => @q)
    end.should change(UserQuestionFeedback, :count).by(1)
  end

  it "should not allow duplicate pairings" do
    @u.user_question_feedbacks.create!(:question_id => @q)
    pair = @u.user_question_feedbacks.build(:question_id => @q)
    pair.save.should_not be_true
  end
  
  it "should respond to rating" do
    @u.user_question_feedbacks.create!(:question_id => @q).should respond_to(:ratings)
  end
end
