module Hourable

  def still_open?
    current_time = Time.now
    flag = true

    hours.each do |hour|
      open_at_time_of_day = TimeOfDay.try_parse hour.open_at
      close_at_time_of_day = TimeOfDay.try_parse hour.close_at
      shift = Shift.new open_at_time_of_day, close_at_time_of_day
      flag = false if hour.bei.include?(current_time.wday.to_s) && (!shift.include? current_time.to_time_of_day)
    end

    flag
  end

  def hours_for_day
    today = Time.now.wday
    hour = hours.where("bei like ?", "%#{today}%").take

    if hour
      "Open from " + hour.open_at + " - " + hour.close_at + " on " + hour.name.capitalize + "."
    else
      "Open all day."
    end
  end

  def hours_for_week

  end
end
