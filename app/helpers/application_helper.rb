module ApplicationHelper

  def correct_author
      @comment = Post.find(params[:post_id])
      unless current_author  and Time.now - @comment.created_at < 3600
        redirect_to root_path(current_author)
      end
    end

  def edited?(param)
    param.created_at != param.updated_at
  end

  def pop_up
    cookies[:"actions"] % 5 == 0
  end



  def nested_comments(comments)
    comments.map do |comment, sub_comments|
      render(comment) + content_tag(:div, nested_comments(sub_comments), :class => 'nested_comments')
    end.join.html_safe
  end
end
