module FeedbacksHelper


  def feedback_status(status)
    i_con = 'fa-heart bg-maroon' if status == "positive"
    i_con = 'fa-exclamation bg-yellow' if status == "negative"
    i_con = 'fa-lightbulb-o bg-aqua' if status == "suggestion"

    return "<i class='fa #{i_con}' title='#{status.to_s.capitalize}'></i>"
  end
end
