#= require "../view_base"

class Stodo.views.list.IndexView extends Stodo.views.ViewBase
	el:           "#contents"
	template:     HoganTemplates["templates/list/index"]
	listTemplate: HoganTemplates["templates/list/list"]

	events:
		"click .js-edit-link": "startEdit"
		"click .js-text-input-close-link": "closeEdit"
		"keydown .text-input input": "updateTitle"

	constructor: (o)->
		super(o)

	render: ->
		$("#contents").html( @template.render( { lists: @collection.toJSON() }, list: @listTemplate ) )

	init: ->
		@collection.bind "add", @updated
		@collection.fetch(
			update: true
			success: @updated
		)

	updated: =>
		@render()

	startEdit: (e)->
		@$('.todo-lists-link').hide()
		@$('.text-input').show()
		@$('.js-list-control' ).hide()
		e.preventDefault()

	closeEdit: ->
		@$('.todo-lists-link').show()
		@$('.text-input').hide()
		@$('.js-list-control' ).show()

	updateTitle: (e)->
		if e.keyCode is 13
			e.stopPropagation()
			e.preventDefault()
			target = e.target
			title = $(target).val()
			console.info "updateTitle"
			@model.save( { title: title }, { patch: true } )
