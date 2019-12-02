class VotesController < ApplicationController
  before_action :find_comment
  before_action :find_vote, only: [:destroy]
def create
  if already_voted?
    flash[:notice] = "You can't like more than once"
  else
      @comment.votes.create(author_id: current_author.id)
  end
  redirect_to post_path(@post)
end

def destroy
  if !(already_voted?)
    flash[:notice] = "Cannot unlike"
  else
    @vote.destroy
  end
  redirect_to post_path(@post)
end

private
def find_comment
  @post = Post.find(params[:post_id])
  @comment = Comment.find(params[:comment_id])
end

def already_voted?
  Vote.where(author_id: current_author.id, comment_id:
  params[:comment_id]).exists?
end

def find_vote
   @vote = @comment.votes.find(params[:id])
end
end
