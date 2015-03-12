json.(@user, :first_name, :last_name, :job_title, :description, :email)

json.partial! 'api/comments/comments', comments: @user.comments

json.portfolio @user.followed_companies do |company|
  json.(company, :name, :ticker, :id)
end

if :signed_in?
  json.logged_in true
end

if @user == current_user
  json.current_user true
end
