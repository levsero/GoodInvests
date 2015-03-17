class Company < ActiveRecord::Base
  validates :ticker, :name, :price, presence: true
  before_validation :ensure_price

  has_many :comments, as: :commentable

  has_many :ratings, as: :rateable

  include PgSearch
  multisearchable :against => [:ticker, :name]

  def price
    read_attribute(:price).to_f.round(2)
  end

  def name
    read_attribute(:name).split().map(&:capitalize).join(" ")
  end

  def latest_price
    update if updated_at < 1.day.ago
    price
  end

  def rating
    return 0 if ratings.count == 0
    (ratings.pluck(:rating).inject(:+) / ratings.count).to_f.round(2)
  end

  def update_price
    # update prices
    last_day = RestClient.get(get_updates(ticker)).split()[1]
    self.price = last_day.split(",")[-1]
    price
  end

  def get_updates(sym)
    url = Addressable::URI.new(
      scheme: "https",
      host: "quandl.com",
      path: "/api/v1/datasets/WIKI/#{sym}.csv",
      query_values: {
        trim_start: "2015-03-03",
        column: "4",
        auth_token: "umr2yxGY6KM1QVWex3Jj" # YOUR API KEY HERE
      }
    ).to_s
    url
  end

  private

  def ensure_price
    self.price || update_price
  end
end
