module ResponsesHelper

  def response_status(question)
    uqf = current_user.user_question_feedbacks.find_by_question_id(question)

    if uqf.nil? || uqf.responses.empty? 
      "none"
    else
      uqf.responses.first.correct? ? "correct" : "incorrect"
    end
  end
end
