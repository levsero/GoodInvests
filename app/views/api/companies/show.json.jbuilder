json.(@company, :name, :price, :ticker)

json.comments @company.comments, :title, :body, :created_at
