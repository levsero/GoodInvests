json.company @companies.each do |company|
  json.(company, :name, :ticker, :price)
end
