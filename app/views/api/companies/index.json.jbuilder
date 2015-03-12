json.companies @companies.each do |company|
  json.(company, :name, :ticker, :id)
  json.following @user && @user.followed_companies.includes(company) ? true : false
end
