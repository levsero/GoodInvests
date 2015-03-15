json.companies @companies.each do |company|
  json.(company, :name, :ticker, :id)
  json.following (@user && @user.followed_companies.include?(company)) ? true : false
end
json.page @page_info
