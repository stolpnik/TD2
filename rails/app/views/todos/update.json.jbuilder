json.array! @list.todos do |todo|
	json.title      todo.title
	json.done       todo.done
	json.start_at   todo.start_at
	json.finish_at  todo.finish_at
	json.updated_at todo.updated_at
	json.created_at todo.created_at
	json.position   todo.position
	json.id         todo.id
	if todo.checked_at
    	json.checked_at todo.checked_at.strftime("%Y-%m-%dT%H:%M:%SZ")
    end
end