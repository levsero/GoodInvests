json.(@company, :name, :price, :ticker)

json.following (@user && @user.followed_companies.include?(@company)) ? true : false

json.partial! 'api/comments/comments', comments: @company.comments

if :signed_in?
  json.logged_in true
end
