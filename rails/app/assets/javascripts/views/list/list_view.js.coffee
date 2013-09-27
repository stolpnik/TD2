#= require ../view_base

class Stodo.views.list.ListView extends Stodo.views.ViewBase
	el:           "#lists"
	template:     HoganTemplates["templates/list/list"]

	events:
		"click .js-edit-link": "startEdit"
		"click .js-text-input-close-link": "closeEdit"
		"keydown .text-input input": "updateTitle"
		"click .js-delete-link": "confirmDestroy"

	initialize: (o)->
		super( o )

		@listenTo @model, "sync", @synced
		@listenTo @model, "destroy", @destroyed

	render: ->
		@$el.append @template.render( @model.toJSON() )
		@setElement "#list_#{@model.get('id')}"

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
			@model.save( { title: title }, { patch: true } )

	confirmDestroy: (e)->
		@alert = new Stodo.views.AlertView( router: @router )
		@alert.on 'ok', @destroy, @
		@alert.on 'hidden.bs.modal', @alertHidden, @
		@alert.show()
		e.preventDefault()
		return false

	alertHidden: ->
		@alert.off()
		@alert.remove()

	destroy: ->
		console.info "destroy", this
		@alert.hide()
		@model.destroy(
			wait: true
			success: @destoryed
			error: -> console.info "failed"
		)

	synced: =>
		console.info "synced"
		@closeEdit()
		if @model.changed?.title
			@$('.todo-lists-link .list-title').text( @model.changed.title )
			@$el.effect "highlight"

	destroyed: =>
		console.info "destroyed"
		@stopListening @model
		@remove()

