json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :contract_string, :renter_string, :area_string, :contract_id, :renter_id, :area_id, :amount
  json.url transaction_url(transaction, format: :json)
end
