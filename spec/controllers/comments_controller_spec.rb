require 'spec_helper'

describe CommentsController do
  before :each do
    @u = User.new( :name => "Ex User",
                   :email => "ex@user.com",
                   :password => "foobar",
                   :password_confirmation => "foobar" )
    @q = Factory(:question, :created_by => @u)
    test_sign_in @u
  end

  describe "POST 'create'" do
    it "should redirect to question" do
      post :create, :question_id => @q, :comment => { :comment => "hello" }
      response.should redirect_to @q
    end
  end
end
