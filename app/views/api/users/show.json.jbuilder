json.(@user, :first_name, :last_name, :job_title, :description)

json.comments @user.comments, :title, :body, :created_at

if :signed_in?
  json.logged_in true
end

if @user == current_user
  json.current_user true
end
