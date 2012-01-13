require 'spec_helper'

describe Rating do
  describe "data validations" do
    it "should require a rating" do
      Rating.new(:user_question_feedback_id => 1).should_not be_valid
    end

    it "should require a user question feedback id" do
      Rating.new(:rating => 3).should_not be_valid
    end
  end
  
  describe "associations" do
    before :each do
      @u = Factory :user
      @q = Factory(:question, :created_by => @u)
      #test_sign_in(@u)
    end

    it "should create a rating from a user for the question" do
      @u.feedback(@q).ratings.new(:rating => 3).should be_valid
    end
  end
end
