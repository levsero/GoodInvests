json.companies @companies.includes(:followers) do |company|
  json.partial! 'api/comments/comments', comments: company.comments.includes(:author)
  json.(company, :name, :ticker, :id)
  json.rating company.rating
  json.following (@user && company.followers.include?(@user)) ? true : false
end
json.comparator = @comparator || "name"
json.page @page_info
