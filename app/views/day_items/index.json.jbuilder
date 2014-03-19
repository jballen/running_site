json.array!(@day_items) do |day_item|
  json.extract! day_item, :day, :title
  json.url day_item_url(day_item, format: :json)
end