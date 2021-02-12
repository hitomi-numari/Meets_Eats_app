module UsersHelper
  def if_event_status?(event)
    if event.event_status == "done"
      link_to t('views.user.rate_please'), event_path(event.id), class:"btn btn-secondary"
    elsif event.event_status == "cancelling"
      t('views.user.cancelling')
    elsif event.event_status == "rated"
      t('views.user.unrated')
    elsif event.event_status == "pending"
      t('views.user.applying')
    else
      t('views.user.rated')
    end    
  end
end
