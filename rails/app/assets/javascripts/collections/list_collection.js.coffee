#= require ../models/list_model

class Stodo.collections.ListCollection extends Backbone.Collection
	model: Stodo.models.ListModel

	url: "/lists.json"

	parse: (data)->
		super( data )
		return data

	toJSON: ->
		arr = super()
		_.each arr, (list, index, arr)->
			undone = _.filter list.todos, (todo, index, arr)->
				return true unless todo.done
			list.undone = undone.length
		return arr