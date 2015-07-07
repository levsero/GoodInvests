json.extract! company, :name, :price, :ticker, :id, :prev_price

json.following (@user && @user.followed_companies.include?(company)) ? true : false
