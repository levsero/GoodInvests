json.most_followed @companies do |company|
  json.(company, :name, :ticker, :id, :count)

  json.following (@user && @user.followed_companies.include?(company)) ? true : false
end

json.comparator = @comparator || "count"

json.most_commented @commented do |company|
  json.(company, :name, :ticker, :id, :count)

  json.following (@user && @user.followed_companies.include?(company)) ? true : false
end
