class Stodo.models.TodoModel extends Backbone.Model
	initialize: (o)->
		super(o)

		if o?.list_id && o.id
			@url = "/lists/#{@get('list_id')}/todos/#{@get('id')}.json"


	defaults:
		title:  null