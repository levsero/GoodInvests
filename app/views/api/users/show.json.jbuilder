json.(@user, :first_name, :last_name, :job_title, :description, :email)
json.rating @user.rating

json.partial! 'api/comments/comments', comments: @user.comments.includes(:author)
json.following (@current_user && @current_user.followed_users.include?(@user)) ? true : false

json.portfolio @user.followed_companies do |company|
  json.(company, :name, :ticker, :id)
  json.following "none"
end

if signed_in?
  json.logged_in true
end

json.picture_url image_url(@user.picture.url(:medium))

if @user == current_user
  json.current_user true
end
