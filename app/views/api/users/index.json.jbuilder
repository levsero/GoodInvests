json.users @users do |user|
  json.(user, :first_name, :last_name, :id)
  json.following (@current_user && @current_user.followed_users.include?(user)) ? true : false
end
json.page @page_info
