module ApplicationHelper
  def bootstrap_class_for(flash_type)
    case flash_type
    when "success"
        "alert-success"
      when "danger"
        "alert-danger"
      when "alert"
        "alert-warning"
      when "notice"
        "alert-info"
      else
        puts flash_type.to_s
    end
  end

  def gender_view(type)
    case type
    when 1
        "男"
      when 2
        "女"
      when 3
        "その他"
      else
        puts "非表示"
    end
  end
  def simple_time_start_at(time)
    time.strftime("%m/%d %H:%M")
  end
  def simple_time_end_at(time)
    time.strftime("%H:%M")
  end

end
