json.array!(@contracts) do |contract|
  json.extract! contract, :id, :title, :renter_id, :area_id, :rate, :date_start, :date_end
  json.url contract_url(contract, format: :json)
end
