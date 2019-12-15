# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    author = Author.find_by_email(params[:email])
    if author&.authenticate(params[:password])
      session[:author_id] = author.id
      redirect_to posts_path
      flash[:success] = 'Logged in!'
    else
      flash.now[:danger] = 'Email or password is invalid'
      render 'new'
    end
  end

  def destroy
    session[:author_id] = nil
    redirect_to posts_path
    flash[:warning] = 'Logged out!'
  end
end
