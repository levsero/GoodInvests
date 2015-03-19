json.notifications @notifications do |notification|
  json.text notification.text
  notify = notification.notifiable
  toggle = notify.class == Comment ? notify.commentable : notify.rateable
  json.url "#{toggle.class.to_s.downcase.pluralize}/#{toggle.id}"
  json.id notification.id
end
