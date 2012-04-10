class QuestionsController < ApplicationController
  #before_filter :authenticate

  def new
    @question = Question.new
    @title = "New Question"
    @categories = categories
    @wrong = @wrong_answers.nil? ? "" : params[:wrong_answer]
#    @wrong = params[:wrong_answer]
    respond_to do |format|
      format.html { render new_question_path }
      format.js
    end
  end

  def create
    @wrong = params[:wrong_answer]
    puts @wrong
    @categories = categories
    respond_to do |format|
      format.html { 
          @question = current_user.questions.build(params[:question].merge( :wrong => @wrong ))
          if @question.save then redirect_to @question else render new_question_path end 
      }
      format.js
    end
  end
  
  def edit
    @title = "Edit Question"
    @question = Question.find(params[:id])
    @categories = categories
    @comments = Comment.comments_on(@question).paginate(:page => params[:page], :per_page => 10)
    @ave_rating = Rating.average_rating(@question)
    #@wrong_answers = params[:wrong_answer] || answers_to_hash(@question.wrong)
    @wrong = params[:wrong_answer].nil? ? @question.wrong : params[:wrong_answer]
    #puts "Got edit request.  params[:wrong_answer][0] was #{params[:wrong_answer][0]}.  @wrong is now #{@wrong}"
    respond_to do |format|
      format.html { render 'edit' }
      format.js
    end
  end
  
  def update
    @question = Question.find(params[:id])
    @categories = categories
    @questions = Question.all
    @comments = Comment.comments_on(@question).paginate(:page => params[:page], :per_page => 10)
    @ave_rating = Rating.average_rating(@question)
    #@wrong_answers = params[:wrong_answer]
    @wrong = params[:wrong_answer].nil? ? @question.wrong : params[:wrong_answer]
    #puts "Got update request.  params[:wrong_answer][0] was #{params[:wrong_answer][0]}.  @wrong is now #{@wrong}"
    if @question.update_attributes(params[:question].merge( :wrong => @wrong ))
      flash[:success] = "Question updated."
      redirect_to edit_question_path(@question)
    else
      @title = "Edit Question"
      render 'edit'
    end
  end

  def show
    if params[:id].to_i != 0
      @question = Question.find(params[:id]) rescue Question.first
      puts "Questions#show"
      @user = current_user
      @title = "Question ##{@question.id}"
      @response = Response.new
      @answers = @question.wrong.values.push(@question.correct)
      puts "Questions#show before get_next"
      @next = get_next(@question.id)
      @prev = get_prev(@question.id)
    else
      redirect_to index_path
    end
  end
  
  def index
    puts params[:category]
    if (params[:category].nil? && params[:id].nil?) || params[:category] == "All"
      @questions = Question.all
    else
      c = params[:category] || params[:id].humanize.titleize
      if c =~ /all/i
        @questions = Question.all #allow this too, even though not a category
      else
        @questions = Question.where("category = '#{c}'")
      end
    end
    @categories = categories << "All"
    @category = c || "All"
    puts params[:category]
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def qlist
    @questions = Question.find_all_by_user_id(current_user)
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def destroy
    Question.find(params[:id]).destroy
    redirect_to byuser_path
  end
  
  def get_next(q)
    if q == Question.last.id
      Question.first
    else
      Question.where("id > ?", q).first 
    end
  end

  def get_prev(q)
    if q == Question.first.id
      Question.last
    else
      Question.where("id < ?", q).first
    end
  end
   
  private
    def categories
      ["Family Medicine", "Internal Medicine", "Pediatrics", "Radiology", "Surgery", "Other"]
    end

=begin    
    def tokenizer
      "|"
    end
    

    def parse_wrong_answers(wrong_h)
      answers = []
      wrong_h.each do |k, v|
        if v.split(tokenizer).first
          answers << v.split(tokenizer).first << tokenizer # splitting on the tokenizer then taking the first prevent nested tokens from blank fields
        end
      end
      answers.to_s
    end
=end
    
end
