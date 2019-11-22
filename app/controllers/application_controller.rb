class ApplicationController < ActionController::Base
  helper_method :current_author
  def current_author
    if session[:author_id]
      @current_author ||= Author.find(session[:author_id])
    else
      @current_author = nil
    end
  end
end
