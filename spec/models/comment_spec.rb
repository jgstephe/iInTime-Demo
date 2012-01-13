require 'spec_helper'

describe Comment do
  before :each do
    @u = User.new( :name => "Ex User",
               :email => "ex@user.com",
               :password => "foobar",
               :password_confirmation => "foobar" )
    @q = Factory(:question, :created_by => @u)
    #test_sign_in @u
  end
  
  it "should create a new comment" do
    lambda do
      @u.feedback(@q).comments.create!(:comment => "hello")
    end.should change(Comment, :count).by(1)
  end
end
