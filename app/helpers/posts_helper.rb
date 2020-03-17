# frozen_string_literal: true

module PostsHelper
  def current_author?(author)
    author == current_author
  end

  def current_author
    if (author_id = session[:author_id])
      @current_author ||= Author.find_by(id: author_id)
    end
  end
end
