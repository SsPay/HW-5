module ApplicationHelper

  def edited?(param)
    param.created_at != param.updated_at
  end
end
