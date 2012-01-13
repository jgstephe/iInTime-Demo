class ResponsesController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @response = current_user.feedback(@question).responses.new(params[:response])
    if @response.save
      redirect_to question_response_path(@question, @response)
    else
      render show_questions_path
    end
  end

  def show
    @response = Response.find(params[:id])
    @question = Question.find((UserQuestionFeedback.find(@response.user_question_feedback_id)).question_id)
    @title = "Response to Question #{@question.id}"
    @rating = Rating.new
    @comment = Comment.new
    @ave_rating = Rating.average_rating(@question)
    @comments = Comment.comments_on(@question).paginate(:page => params[:page], :per_page => 10)
    @next = Question.last #get_next(@question.id)
  end

end
