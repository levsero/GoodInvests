json.(@company, :name, :price, :ticker, :prev_price)
json.rating @company.rating

json.following (@user && @user.followed_companies.include?(@company)) ? true : false

json.partial! 'api/comments/comments', comments: @company.comments.includes(:author)

if :signed_in?
  json.logged_in true
end
