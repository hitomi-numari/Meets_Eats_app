class ApplyForEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event
  enum status:{ unselected:0, selected:1}

  # def toggle_status!(status, apply)
  def toggle_status!(status)
    if unselected?
      selected!
    else
      unselected!
    end
  end

  # def toggle_event_status(event_status)
  #   if pending?
  #     done!
  #   else
  #     pending!
  #   end
  # end

end
