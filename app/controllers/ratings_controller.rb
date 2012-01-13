class RatingsController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @response = Response.find(params[:response_id])
    @uqf = current_user.feedback(@question)
    if set_new_rating(params[:rating])
      flash[:success] = "You just gave this question a rating of #{@uqf.ratings.first.rating}"
    else
      flash[:error] = "Something went wrong with the rating! Try again later"
    end
    redirect_to [@question, @response]
  end

  private
    def set_new_rating(rating)
      if @uqf.ratings.any? # if there is a current rating
        @uqf.ratings.first.update_attributes(rating)
      else
        @uqf.ratings.new(rating).save
      end
    end
end
