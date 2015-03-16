json.companies @companies do |company|
  json.(company, :name, :ticker, :id)
  json.following (@user && @user.followed_companies.include?(company)) ? true : false
end
json.comparator = @comparator || "name"
json.page @page_info
