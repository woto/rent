json.array!(@maps) do |map|
  json.extract! map, :id, :title, :map
  json.url map_url(map, format: :json)
end
