class CommentsController < ApplicationController
    before_action :correct_author, only: [:edit, :update, :destroy, :new]
    before_action :hour_for_comment_editing, only: [:edit, :update]
    before_action :banned?, only: [:new, :create]

    def correct_author
        @comment = Post.find(params[:post_id])
        unless current_author
          redirect_to root_path(current_author)
        end
      end

      def hour_for_comment_editing
        Time.now - @comment.created_at < 3600
      end

    def new
      @post = Post.find(params[:post_id])
      @comment = Comment.new(:parent_id => params[:parent_id])
    end


    def edit
      @post = Post.find(params[:post_id])
      @comment = @post.author.comments.find(params[:id])
      respond_to do |format|
        format.js {render 'edit', status: :created, location: @post}
        flash[:success] = "Comment successfully edited"
      end
    end


  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.author_id = current_author.id
    if @comment.ancestors.count <= 4
          respond_to do |format|
            if @comment.save
              format.js {render 'create', status: :created, location: @post}
              flash[:success] = 'Comment was successfully created.'
            else
              flash[:danger] = @comment.errors.full_messages.first
            end
          end
        else
          respond_to do |format|
            flash[:warning] = 'To much comments in one tree (5 comments max)'
          end
        end
  end


  def update
    @comment = Comment.find(params[:id])
    @post = Post.find(params[:post_id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.js {render 'update', status: :created, location: @post}
        flash[:success] = 'Comment was successfully updated.'
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
    respond_to do |format|
      format.js {render 'destroy', status: :created, location: @post}
      format.html { redirect_to @post, notice: 'Comment was successfully destroyed.' }
    end
    else
      redirect_to root_path
    end

  end

  private

  def comment_params
    params.require(:comment).permit(:body, :author_id, :parent_id)
  end
end
