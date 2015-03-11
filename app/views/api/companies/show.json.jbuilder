json.(@company, :name, :price, :ticker)

json.comments @user.comments, :title, :body, :created_at
