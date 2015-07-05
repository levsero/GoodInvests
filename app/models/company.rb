class Company < ActiveRecord::Base
  validates :ticker, :name, :price, presence: true
  before_validation :ensure_price

  has_many :comments, as: :commentable
  has_many :follows, as: :followable, dependent: :destroy
  has_many :followers, through: :follows, source: :follower
  has_many :ratings, as: :rateable

  include PgSearch
  multisearchable :against => [:ticker, :name]

  def price
    read_attribute(:price).round(2)
  end

  def prev_price
    read_attribute(:prev_price).round(2)
  end

  def name
    read_attribute(:name).split().map(&:capitalize).join(" ")
  end

  def rating
    return 0 if ratings.count == 0
    (ratings.pluck(:rating).inject(:+).to_f / ratings.count).round(2)
  end

  def update_prices
    p "price:#{price}"
    return if updated_at > 1.day.ago || prev_price.nil?
    data = RestClient.get(get_updates(ticker)).split()
    last_day = data[1]
    prev_day = data[2]
    self.price = last_day.split(",")[-1]
    self.prev_price = prev_day.split(",")[-1]
    save!
  end

  def get_updates(sym)
    url = Addressable::URI.new(
      scheme: "https",
      host: "quandl.com",
      path: "/api/v1/datasets/WIKI/#{sym}.csv",
      query_values: {
        trim_start: "2015-03-03",
        column: "4",
        auth_token: ENV["QUANDL_API"]
      }
    ).to_s
    url
  end

  private

  def ensure_price
    self.price || update_prices
  end
end
