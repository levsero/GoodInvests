json.extract! company, :name, :price, :ticker, :id, :prev_price

# json.partial! 'api/comments/comments', comments: company.comments
json.following (@user && @user.followed_companies.include?(company)) ? true : false

if :signed_in?
  json.logged_in true
end
