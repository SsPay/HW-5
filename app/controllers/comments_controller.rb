class CommentsController < ApplicationController
    before_action :correct_author, only: [:edit, :update, :destroy, :new]
    before_action :banned?, only: [:new, :create]

    def correct_author
        @comment = Post.find(params[:post_id])
        unless current_author  and Time.now - @comment.created_at < 3600
          redirect_to root_path(current_author)
        end
      end

    def new
      @post = Post.find(params[:post_id])
      @comment = Comment.new(:parent_id => params[:parent_id])
    end


    def edit
      @post = Post.find(params[:post_id])
      @comment = @post.author.comments.find(params[:id])
    end


  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.author_id = current_author.id
    if @comment.ancestors.count <= 4
          respond_to do |format|
            if @comment.save
              format.html { redirect_to @post, notice: 'Comment was successfully created.' }
            else
              format.html { redirect_to @post, alert: @comment.errors.full_messages.first }
            end
          end
        else
          respond_to do |format|
            format.html { redirect_to @post, alert: 'To much comments in one tree (5 comments max)' }
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
    params.require(:comment).permit(:body, :author_id, :parent_id)
  end
end
