#json.array!(@todos) do |todo|
  #json.extract! todo, :title, :id, :done, :position, :start_at, :finish_at
  #json.url list_todos_url(todo, format: :json)
#end

json.extract! @list, :title, :id, :todos