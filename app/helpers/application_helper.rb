module ApplicationHelper

  def fix_url(str)
    str.starts_with?('http://') ? str : "http://#{str}"
  end

  def format_datetime(time)
    time.strftime("%B %d %Y, %T %Z")
  end

end
