module ApplicationHelper
  def page_title
    if current_user.nil? && @title.blank?
      "iInTime"
    else if current_user.nil?
      @title
    else if @title.blank?
      current_user.name
    else
      "#{@title} | #{current_user.name}"
    end;end;end;
  end

  def wrap(content)
    sanitize(raw(content.split.map{ |s| wrap_long_string(s) }.join(' ')))
  end
  
  private
    def wrap_long_string(text, max_width = 30)
      zero_width_space = "&#8203"
      regex = /.{1,#{max_width}}/
      (text.length < max_width) ? text :
      		    text.scan(regex).join(zero_width_space)
    end
end
