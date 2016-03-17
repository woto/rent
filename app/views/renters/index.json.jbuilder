json.array!(@renters) do |renter|
  json.extract! renter, :id, :title, :rate, :date_start, :date_end, :account
  json.url renter_url(renter, format: :json)
end
