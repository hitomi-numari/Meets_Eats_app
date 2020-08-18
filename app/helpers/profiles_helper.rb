module ProfilesHelper

  def calc_ages(age)
    case age
    when 20..24
      "20代前半"
    when 25..30
      "20代後半"
    when 31..34
      "30代前半"
    when 35..40
      "30代後半"
    when 41..44
      "40代前半"
    when 45..50
      "40代後半"
    when 51..54
      "50代前半"
    when 55..60
      "50代後半"
    when 61..64
      "60代前半"
    end
  end

end
