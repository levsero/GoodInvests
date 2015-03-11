json.(@user, :first_name, :last_name, :job_title, :description)

json.comments @user.comments, :title, :body, :created_at
