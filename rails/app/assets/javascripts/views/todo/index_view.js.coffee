#= require "../view_base"
#= require "../../models/list_model"
#= require "../../collections/todo_collection"

class Stodo.views.todo.IndexView extends Stodo.views.ViewBase
	el:           "#contents"
	template:     HoganTemplates["templates/todo/index"]
	todoTemplate: HoganTemplates["templates/todo/todo"]

	events:
		"change:position" : "update"
		"change:checked"  : "update"

	constructor: (o)->
		super(o)

	init: ( id )->
		@list_id = id
		@count = 0
		@collection = new Stodo.collections.TodoCollection( list_id: @list_id )
		@collection.fetch(
			update: true
			success: @loaded
		)

	remove: ->
		$(".sortable").sortable( 'destroy' )
		@super()

	update: =>
		console.info "update!!!"
		_.each @todos, (view) ->
			view.stopListening()
			view.remove()
		@renderChildren()

	updateOrder: (e, ui)=>
		id = ui.item.attr("id").split( "_" )[1]
		position = ui.item.index()
		model = @collection.findWhere id: id - 0
		model.set "position", position + 1
		model.save()

	toggleCheck: ->
		console.info "update!!!"
		@collection.fetch(
			update: true
			success: @update
		)

	render: ->
		$("#contents").html( @template.render( { list: @collection.listModel.toJSON() } ) )
		@renderChildren()
		$(".sortable").sortable( axis: 'y', update: @updateOrder )

	renderChildren: ->
		@todos = []
		@collection.sortByPosition()
		_.each @collection.models, (model)=>
			view = new Stodo.views.todo.TodoView( model: model )
			@listenTo view, 'update:checked', @toggleCheck
			view.render()
			@todos.push view

	loaded: (collection, response, options)=>
		@render()
