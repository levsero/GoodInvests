json.companies @companies.includes(:followers) do |company|
  json.(company, :name, :ticker, :id)
  json.following (@user && company.followers.include?(@user)) ? true : false
end
json.comparator = @comparator || "name"
json.page @page_info
