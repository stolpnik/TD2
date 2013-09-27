#= require "../view_base"

class Stodo.views.list.NewView extends Stodo.views.ViewBase
	el:           "#contents"
	template:     HoganTemplates["templates/list/new"]

	events:
		"submit #new-list": "save"

	constructor: (o)->
		super(o)
		@model = new @collection.model()

	render: ->
		$("#contents").html @template.render()

	save: (e)->
		e.preventDefault()
		e.stopPropagation()
		@model.unset "errors"
		params = @serializeToObject @$("form")
		@model = new @collection.model( params )

		@collection.create(@model.toJSON(),
			success: (list) =>
				@model = list
				@router.navigate "//index", trigger: true

			error: (list, jqXHR) =>
				@model.set({errors: $.parseJSON(jqXHR.responseText)})
		)
