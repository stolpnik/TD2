#= require "../view_base"
#= require "./list_view"

class Stodo.views.list.IndexView extends Stodo.views.ViewBase
	el:           "#contents"
	template:     HoganTemplates["templates/list/index"]

	constructor: (o)->
		super(o)

	render: ->
		if @views?.length > 0
			@removeAllChildren()

		@views = []
		$("#contents").html( @template.render( { lists: @collection.toJSON() } ) )
		_.each( @collection.models, (model)->
			view = new Stodo.views.list.ListView( model: model )
			view.render()
		)

	init: ->
		@collection.fetch(
			update: true
			success: @updated
		)

	remove: ->
		@removeAllChildren()

	removeAllChildren: ->
		_.each @views, (view)->
			view.remove()

	updated: =>
		@render()

