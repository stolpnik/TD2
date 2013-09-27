class Stodo.models.ListModel extends Backbone.Model
	initialize: (o)->
		super(o)
		if @get 'id'
			@url = "/lists/#{@get('id')}.json"

	defaults:
		title: null

	toJSON: ->
		list = super()
		undone = _.filter list.todos, (todo, index, arr)->
			return true unless todo.done
		list.undone = undone.length
		return list
