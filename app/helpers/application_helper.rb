module ApplicationHelper
  # optional parameter: selected=nil, if nothing parsed in then it use the default value "nil"
  def options_for_video_reviews(selected=nil)
    options_for_select([5,4,3,2,1].map{|n| [pluralize(n, "Star"), n]}, selected)
  end
end
