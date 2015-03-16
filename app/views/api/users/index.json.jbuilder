json.users @users do |user|
  json.(user, :first_name, :last_name, :id)
end
json.page @page_info
