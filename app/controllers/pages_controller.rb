class PagesController < ApplicationController
  def home
    redirect_to (signed_in? ? current_user : signin_path)
  end

end
