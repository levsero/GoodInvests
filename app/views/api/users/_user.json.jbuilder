json.extract! user, :first_name, :last_name, :job_title, :description, :id
if user.picture.url(:thumb)
  json.picture_url image_url(user.picture.url(:thumb))
end
