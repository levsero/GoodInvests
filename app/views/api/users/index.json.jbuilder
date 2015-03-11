json.users @users.each do |user|
  json.(user, :first_name, :last_name)
end
