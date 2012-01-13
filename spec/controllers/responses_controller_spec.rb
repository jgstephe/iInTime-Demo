require 'spec_helper'

describe ResponsesController do
  render_views

  before :each do
#    @u = User.new( :name => "Ex User",
#                   :email => "ex@user.com",
#                   :password => "foobar",
#                   :password_confirmation => "foobar" )
#    @q = { :content => "content",
#            :correct => "correct",
#            :other_a => "wrong",
#            :other_b => "wrong",
#            :other_c => "wrong",
#            :other_d => "wrong",
#            :title   => "title",
#            :category=> "family",
#            :expert_answer => "expert" }
#    @u.save
#    @u = User.find(@u)
#    uq = @u.questions
#    uq.create!(@q)
    @u = Factory :user
    @q = Factory(:question, :created_by => @u)
    @question = @q
    test_sign_in(@u)
    @resp = @u.feedback(@q).responses.create!( :content => "answer" )
    @comment = Comment.new
    puts "User: #{@u}\tQuestion: #{@q}\tResponse: #{@resp}"
  end

  describe "POST 'create'" do
    it "should create a response" do
      lambda do
        #test_sign_in(@u)
        post :create, :user_id => @u, :question_id => @q, :response => { :content => "answer"}
      end.should change(Response, :count).by(1)
    end
  end

  describe "POST 'show'" do
    before :each do
      post 'show', :question_id => @q, :id => @resp
    end

    it "should be successful" do
      response.should be_success
    end
    
    it "should show the question number" do
      response.should have_selector("div", :content => "#{@q.id}")
    end
    
    it "should show the response" do
      response.should have_selector("div", :content => "answer")
    end
    
    describe "rating" do
      it "should show the rating box" do
        response.should have_selector("div", :content => "Rate this Question:")
      end
      
      it "should show the rating options" do
        (1..5).each do |n|
          response.should have_selector("label", :content => "#{n}")
        end
      end
      
      it "should show the AVERAGE rating" do
        @u.feedback(@q).ratings.create!(:rating => "3", :user_id => @u)
        @u.feedback(@q).ratings.create!(:rating => "4", :user_id => @u)
        post :show, :id => @q
        response.should have_selector("div", :content => "rating is 3.5.")
      end
    end
  end
end
