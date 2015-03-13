# json.total_count @search_results.total_count

json.results do
  json.array! @search_results do |search_result|
    if search_result.searchable_type == "Company"
      json.partial! "api/companies/company", company: search_result.searchable
      json._type "Company"
    else
      json.partial! "api/users/user", user: search_result.searchable
      json._type "User"
    end
  end
end
