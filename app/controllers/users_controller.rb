class UsersController < ApplicationController
  before_filter :authenticate, :only => :show
  before_filter :correct_user, :only => :show

  def new
    @user = User.new
    @title = "Sign Up"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to iInTime"
      redirect_to @user
    else
      @title = "Sign Up"
      render 'new'
    end
  end

  def show
    @title = "Home"
    @questions = Question.find_all_by_user_id(current_user).first(5)
  end
  
  def home
    redirect_to current_user
  end
  
  private    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path, :notice => "You do not have access to this page") unless allowed_access? @user
    end
    
    def allowed_access?(user)
      current_user? user
    end
end
