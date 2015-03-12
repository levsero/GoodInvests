json.(@company, :name, :price, :ticker)

json.partial! 'api/comments/comments', comments: @company.comments

if :signed_in?
  json.logged_in true
end
