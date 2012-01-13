require 'spec_helper'

describe UsersController do

  before :each do
    @user_data =  { :name => "Ex User",
                    :email => "user1@ex.com",
                    :password => "foobar",
                    :password_confirmation => "foobar" }
    @u = Factory :user
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST 'create'" do
    describe "on success" do
      it "should redirect to user show" do
        post :create, :user => @user_data
        response.should redirect_to('/users/2')
      end
      
      it "should sign the user in" do
        post :create, :user => @user_data
        controller.should be_signed_in
      end
    end
    
    describe "on failure" do
      it "should render the new user page" do
        post :create, :user => {}
        response.should render_template(:new)
      end
    end
  end

  describe "POST 'show'" do
    it "should be successful" do
      test_sign_in(@u)
      post :show , :id => @u
      response.should be_success
    end
  end

end
