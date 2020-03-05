# frozen_string_literal: true

class PostsController < ApplicationController
  impressionist actions: [:show], unique: [:session_hash]
  before_action :set_post, only: %i[show edit update destroy]
  before_action :correct_author, only: %i[edit update destroy]
  before_action :have_rights?, only: %i[create new edit update destroy]
  before_action :actions_check
  before_action :banned?, only: %i[new create update]

  def correct_author
    @post = Post.find_by(id: params[:id])
    redirect_to root_path(current_author) unless current_author
  end

  def index
    @posts = if params[:search]
               Post.search(params[:search]).order('created_at DESC')
             else
               Post.all.order('created_at DESC')
             end
  end

  def show
    impressionist @post
  end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = Post.new(post_params)
    @post.author = current_author
    @post.plain_text = @post.content.to_plain_text
    respond_to do |format|
      if @post.save
        flash[:success] = 'Post was successfully created.'
        format.html { redirect_to @post }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.js { render 'destroy', status: :destroy, location: @post }
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :picture, session[:author_id])
  end

  def actions_check
    cookies[:actions] = if cookies[:actions]
                          cookies[:actions].to_i + 1
                        else
                          0
      end
  end
end
