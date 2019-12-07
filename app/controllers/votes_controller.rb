class VotesController < ApplicationController
  before_action :find_comment
  before_action :find_vote, only: [:destroy]
  def create
      if already_voted?
        flash[:alert] = 'You have already voted'
      else
        if @comment.votes.create!(author: current_author, count: 1)
          redirect_to @post
        else
          respond_to do |format|
            format.html { redirect_to @post, alert: 'You have already voted' }
          end
        end
      end
    end

def dislike
    if already_voted?
      flash[:alert] = 'You already voted'
    else
      if @comment.votes.create!(author: current_author, count: -1)
        redirect_to @post
      else
        respond_to do |format|
          format.html { redirect_to @post, alert: 'You have already voted' }
        end
      end
    end
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
