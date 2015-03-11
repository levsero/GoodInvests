json.(@company, :name, :price, :ticker)

json.comments @company.comments, :title, :body, :created_at

if :signed_in?
  json.logged_in true
end
