#= require ../models/todo_model
#= require ../models/list_model

class Stodo.collections.TodoCollection extends Backbone.Collection
	model: Stodo.models.TodoModel
	listModel: null

	constructor: (o)->
		super(o)
		@setURL( o.list_id ) if o?.list_id

	parse: (d)->
		@listModel ||= new Stodo.models.ListModel( id: d.id, title: d.title )
#		super( d.todos )
		return d.todos

	setURL: (id)->
		@url = "/lists/#{id}/todos.json"

	sortByPosition: ->
		console.info "sortByPosition"
		@models.sort (a,b)->
			ap = a.get "position"
			bp = b.get "position"
			if ap < bp
				return -1
			else if ap > bp
				return 1
			else
				return 0