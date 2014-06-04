module Hourable

  def still_open?
    current_time = Time.now
    flag = false

    if hours.empty?
      flag = true
    else
      hours.each do |hour|
        open_at_time_of_day = TimeOfDay.try_parse hour.open_at
        close_at_time_of_day = TimeOfDay.try_parse hour.close_at
        shift = Shift.new open_at_time_of_day, close_at_time_of_day
        flag = true if hour.desc.include?(current_time.wday.to_s) && (shift.include? current_time.to_time_of_day)
      end
    end

    flag
  end

  def hours_for_day
    today = Time.now.wday
    hour = Hour.where("desc like ?", "#{today}").take
    "Open from " + hour.open_at + " - " + hour.close_at + "."
  end

  def hours_for_week

  end

end