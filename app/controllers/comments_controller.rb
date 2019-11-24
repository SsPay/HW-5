class CommentsController < ApplicationController
    before_action :correct_author, only: [:edit, :update, :destroy]

  def correct_author
      @comment = Post.find(params[:post_id])
      unless current_author
        redirect_to root_path(current_author)
      end
    end

    def edit
      @post = Post.find(params[:post_id])
      @comment = @post.author.comments.find(params[:id])
    end


  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.author_id = current_author.id
    respond_to do |format|
      #dev, del later
      # ##############
    if @comment.save
      format.html { redirect_to @post, notice: 'good' }
    else
      format.html { redirect_to @post, notice: 'bad' }
      end
    end
  end


  def update
    @comment = Comment.find(params[:id])
    @post = Post.find(params[:post_id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    if (current_author.id == @comment.author_id)
    @comment.destroy
    redirect_to post_path(@post)
      #add mess
      # #############
    else
      redirect_to root_path
      #add smth instead
      # #############
    end

  end

  private

  def comment_params
    params.require(:comment).permit(:body, :author_id, :user)
  end
end
