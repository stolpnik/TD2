#= require "../view_base"
#= require "../../models/list_model"
#= require "../../collections/todo_collection"

class Stodo.views.todo.NewView extends Stodo.views.ViewBase
	el:           "#contents"
	template: HoganTemplates["templates/todo/new"]

	events:
		"submit #new-todo": "save"

	constructor: (o)->
		super(o)

	render: (id)->
		@list_id = id
		@collection = new Stodo.collections.TodoCollection( list_id: @list_id )
		@model = new @collection.model()
		@$el.html( @template.render( list_id: @list_id ) )

	save: (e)->
		e.preventDefault()
		e.stopPropagation()
		@model.unset "errors"
		params = @serializeToObject @$("form")
		@model = new @collection.model( params )

		@collection.create(@model.toJSON(),
			success: (todo) =>
				@model = todo
				@router.navigate "#/#{@list_id}/todos", trigger: true

			error: (list, jqXHR) =>
				@model.set({errors: $.parseJSON(jqXHR.responseText)})
		)
