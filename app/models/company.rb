class Company < ActiveRecord::Base
  validates :ticker, :name, :price, presence: true
  after_initialize :ensure_price

  def price
    read_attribute(:price).to_f
  end

  def latest_price
    update if updated_at < 1.day.ago
    price
  end

  def update_price!
    # update prices
    last_day = RestClient.get(get_updates(self.ticker)).split()[1]
    self.price = last_day.split(",")[-1]

    self.save
    self.price
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
    self.price || update_price!
  end
end
