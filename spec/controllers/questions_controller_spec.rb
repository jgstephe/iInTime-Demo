require 'spec_helper'

describe QuestionsController do
  render_views

  describe "POST 'show'" do
    before :each do
      @u = User.new( :name => "Ex User",
               :email => "ex@user.com",
               :password => "foobar",
               :password_confirmation => "foobar" )
      @q = Factory(:question, :created_by => @u)
      #test_sign_in(@u)
    end
    
    it "should be successful" do
      post 'show', :id => @q
      response.should be_success
    end
    
    describe "display" do
      before :each do
        post 'show', :id => @q
      end
      
      it "should show the question" do
        response.should have_selector("div", :content => @q[:content].capitalize)
      end
      
      describe "response" do
        it "should show the correct answer" do
          response.should have_selector("label", :content => @q[:correct].capitalize)
        end
      
        it "should show four incorrect answers" do
          response.should have_selector("label", :content => @q[:other_a].capitalize)
          response.should have_selector("label", :content => @q[:other_b].capitalize)
          response.should have_selector("label", :content => @q[:other_c].capitalize)
          response.should have_selector("label", :content => @q[:other_d].capitalize)
        end
      end
    end    
  end
  
  describe "GET 'new'" do
    it "should be successful" do
      @u = Factory :user
      test_sign_in(@u)
      get 'new'
      response.should be_success
    end
  end

end
