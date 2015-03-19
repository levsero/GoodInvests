json.extract! user, :first_name, :last_name, :job_title, :description, :id
if user.picture.url(:thumb)
  json.picture_url image_url(user.picture.url(:thumb))
end
json.notifications_count user.notifications.unread.count

json.notifications user.notifications.unread.includes(:notifiable) do |notification|
  json.text notification.text
  notify = notification.notifiable
  toggle = notify.class == Comment ? notify.commentable : notify.rateable
  json.url "#{toggle.class.to_s.downcase.pluralize}/#{toggle.id}"
  json.id notification.id
end
