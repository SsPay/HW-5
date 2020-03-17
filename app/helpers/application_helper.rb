# frozen_string_literal: true

module ApplicationHelper
  def correct_author
    @comment = Post.find(params[:post_id])
    redirect_to root_path(current_author) unless current_author
  end

  def hour_for_comment_editing
    unless Time.now - @comment.created_at < 3600
    end
  end

  def edited?(param)
    param.created_at + 0.2 < param.updated_at
  end

  def pop_up
    cookies[:actions] % 5 == 0
  end

  def nested_comments(comments)
    comments.map do |comment, sub_comments|
      render(comment) + content_tag(:div, nested_comments(sub_comments), class: 'nested_comments')
    end.join.html_safe
  end
end
