module ScalesHelper
  def is_editable?
    @scale.user == nil || @scale.user == current_user
  end
end
