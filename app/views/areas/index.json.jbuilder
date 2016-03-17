json.array!(@areas) do |area|
  json.extract! area, :id, :map_id, :ref, :title
  json.url area_url(area, format: :json)
end
