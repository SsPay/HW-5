module ApplicationHelper

  def edited?(param)
    param.created_at != param.updated_at
  end

  def pop_up
    cookies[:"actions"] % 5 == 0
  end
end
