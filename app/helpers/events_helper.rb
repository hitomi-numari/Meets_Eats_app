module EventsHelper
  def genre_image(genre_id)
    case genre_id
      when 1
        "/assets/relationship.jpg/"
      when 2
        "/assets/work.jpg/"
      when 3
        "/assets/family.jpg/"
      when 4
        "/assets/human.jpg/"
      when 5
        "/assets/hobby.jpg/"
      when 6
        "/assets/other.jpg/"
      else
    end
  end
end
