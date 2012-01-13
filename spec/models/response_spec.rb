require 'spec_helper'

describe Response do

  describe "response validations" do
    before :each do
      @u = Factory :user
      @q = Factory(:question, :created_by => @u)
      #test_sign_in(@u)
      @response = { :content => "hello" }
    end
    
    describe "failure" do
      it "should require a user_question_feedback id" do
        Response.new(@response.merge(:user_question_feedback_id => "")).should_not be_valid
      end
      
      it "should require a response" do
        Response.new(@response.merge(:content => "")).should_not be_valid
      end
    end
    
    describe "success" do
      it "should create a response given valid attributes" do
        @u.feedback(@q).responses.new(@response).should be_valid
      end
    end
  end
end
