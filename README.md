##GoodInvests
GoodInvests is a website designed to help people research and discover the best investments on the market. The backend is built using Ruby on Rails for an API, with the frontend developed in backbone.js.

GoodInvests [live link](goodinvests.co)

### Features
Users can

* register and login with an email address, or with Facebook or Google accounts.
* Add companies to their portfolio.
* Rate and comment on companies or other users.
* Receive a notification when someone rates or comments on them or a company in their portfolio.
* Mark individual notifications or mark all as read.
* View User and company profiles
* Reset password via email reset link
* Upload profile pictures

Search for

* Companies by name or ticker symbol.
* Users by first or last name.

### Technical Details
* Makes extensive use of Backbone models, collections with some custom Ajax requests and routes.
* Facebook and Google login enabled through OmniAuth.
* Password reset emails sent through ActionMailer.
* Picture upload handled by Paperclip.
* Pictures stored on AWS
* All api keys are hidden using Figaro
* Pagination enabled in search results with Kaminari gem
* Consumes Quandl’s API for stock prices.
* Bootstraps user and company data on page load to avoid extra AJAX requests.
* Comments, Ratings, Follows, Notification, Search tables are all polymorphic associations shared between [Company](app/models/company.rb) and [User](app/models/user.rb) to keep the database normalized and the code DRY.

### TODO

* Allow searching for partial words.
* Update search results as the user types.
* Allow users to follow other users.
* Allow users to create collections of companies other than portfolio
* Make input errors when signing in inline instead of absolute.
