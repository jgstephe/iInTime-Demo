class CommentsController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @response = Response.find(params[:response_id])
    @comment  = current_user.feedback(@question).comments.new(params[:comment])
    if @comment.save
      flash[:success] = "You just commented on Question #{@question}"
    else
      flash[:error] = "Comment failed"
    end
    redirect_to question_response_path(@question, @response)
  end

end
