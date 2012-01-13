require 'spec_helper'

describe RatingsController do

  def post_create
    post :create, :question_id => @q, :rating => {:rating => "3"}
  end

  before :each do
    @u = Factory :user
    @q = Factory(:question, :created_by => @u)
    test_sign_in(@u)
  end

  describe "POST 'create'" do
    
    it "should create a new rating" do
      lambda do
        post 'create', :question_id => @q, :rating => {:rating => "3"}
      end.should change(Rating, :count).by(1)
    end
    
    it "should redirect to the question" do
      post_create.should redirect_to(@q)
    end
  end

end
