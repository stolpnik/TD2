json.extract! @todo, :title, :position, :done, :start_at, :finish_at, :updated_at, :created_at, :id
if @todo.checked_at
	json.checked_at @todo.checked_at.strftime("%Y-%m-%dT%H:%M:%SZ")
end