json.array!(@lists) do |list|
  json.extract! list, :title, :id, :todos
  json.url list_url(list, format: :json)
end
