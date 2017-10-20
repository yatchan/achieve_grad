module NotificationsHelper
  def posted_time(time)
    time > Date.today ? "#{time_ago_in_words(time)}" : time.strftime('%m月%d日')
  end
  def read_status(read)
    if read==false
    "未読"
    else
    "既読"
    end
  end
end
