json.users @users do |user|
  json.(user, :first_name, :last_name, :job_title, :description, :rating, :id)
  json.partial! 'api/comments/comments', comments: user.comments
  json.following (@current_user && @current_user.followed_users.include?(user)) ? true : false
end
json.page @page_info
