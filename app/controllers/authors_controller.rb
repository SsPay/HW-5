# frozen_string_literal: true

class AuthorsController < ApplicationController
  before_action :set_author, only: %i[show edit update destroy]
  before_action :correct_author, only: %i[edit update destroy]

  def correct_author
    @authors = Author.find_by(id: params[:id])
    redirect_to root_path(current_author) unless current_author
  end

  def index
    @authors = Author.all
  end

  def new
    @author = Author.new
  end

  def edit; end

  def create
    @author = Author.new(author_params)
    respond_to do |format|
      if @author.save
        format.html { redirect_to root_path }
        flash[:success] = 'You have successfully registered. Check your email.'
        format.json { render :show, status: :created, location: @author }
      else
        format.html { render :new }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @author.update(author_params)
        format.html { redirect_to root_path }
        flash[:succes] = 'author was successfully updated.'
        format.json { render :show, status: :ok, location: @author }
      else
        format.html { render :edit }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @author.destroy
    respond_to do |format|
      format.html { redirect_to authors_url, notice: 'author was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def confirm_email
    author = Author.find_by_confirm_token(params[:id])
    if author
      author.email_activate
      flash[:success] = "Welcome to the Sample App! Your email has been confirmed.
      Please sign in to continue."
      redirect_to login_path
    else
      flash[:error] = 'Sorry. User does not exist'
      redirect_to root_url
    end
  end

  private

  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:login, :email, :password, :password_confirmation)
  end
end
