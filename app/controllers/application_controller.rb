# frozen_string_literal: true

require 'action_text'
class ApplicationController < ActionController::Base
  helper ActionText::Engine.helpers

  helper_method :current_author, :banned?

  def current_author
    if session[:author_id]
      @current_author ||= Author.find(session[:author_id])
    else
      @current_author = nil
    end
  end

  def banned?
    if current_author.present?
      if current_author.banned == true
        redirect_back(fallback_location: root_path)
        flash[:danger] = 'You are banned☹️'
      end
    end
  end

  def have_rights?
    redirect_back(fallback_location: root_path) unless current_author
  end
end
