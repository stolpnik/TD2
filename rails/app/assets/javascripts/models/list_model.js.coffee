class Stodo.models.ListModel extends Backbone.Model
	initialize: (o)->
		super(o)
		if @get 'id'
			@url = "/lists/#{@get('id')}.json"

	defaults:
		title: null
