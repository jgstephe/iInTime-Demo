require 'spec_helper'

describe Question do

  describe "submission" do
    before :each do
      @u = User.new( :name => "Ex User",
                     :email => "ex@user.com",
                     :password => "foobar",
                     :password_confirmation => "foobar" )
      #@q = Factory(:question, :created_by => @u)
      #test_sign_in(@u)
      @question = { :content => "content",
                    :correct => "correct",
                    :other_a => "wrong",
                    :other_b => "wrong",
                    :other_c => "wrong",
                    :other_d => "wrong",
                    :title   => "title",
                    :category=> "family",
                    :expert_answer => "expert" }
      @blank  = ""
    end
    
    it "should require content" do
      @u.questions.new(@question.merge(:content => @blank)).should_not be_valid
    end
    
    it "should require a correct answer" do
      @u.questions.new(@question.merge(:correct => @blank)).should_not be_valid
    end
    
    it "should require four wrong answers" do
      @u.questions.new(@question.merge(:other_a => @blank)).should_not be_valid
      @u.questions.new(@question.merge(:other_b => @blank)).should_not be_valid
      @u.questions.new(@question.merge(:other_c => @blank)).should_not be_valid
      @u.questions.new(@question.merge(:other_d => @blank)).should_not be_valid
    end

    it "should require a question title" do
      @u.questions.new(@question.merge(:title => @blank)).should_not be_valid
    end
    
    it "should require a category" do
      @u.questions.new(@question.merge(:category => @blank)).should_not be_valid
    end

    it "should NOT require an expert answer" do
      @u.questions.new(@question.merge(:expert_answer => @blank)).should be_valid
    end

    it "should require a user creator" do
      Question.new.should_not be_valid
    end
    
    it "should respond to user" do
      @u.questions.new(@question).should respond_to(:user)
    end
  end
end
