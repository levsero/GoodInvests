json.companies @companies.each do |company|
  json.(company, :name, :ticker, :price, :id)
end
