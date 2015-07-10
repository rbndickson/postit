module ApplicationHelper

  def fix_url(str)
    str.starts_with?('http://') ? str : "http://#{str}"
  end

  def format_datetime(time)
    time.to_formatted_s(:short)
  end

end
