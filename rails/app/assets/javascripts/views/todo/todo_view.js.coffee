class Stodo.views.todo.TodoView extends Backbone.View
	CHECKED_CLASS = 'icon-check'
	UNCHECKED_CLASS = 'icon-unchecked'

	el: "#todo-list"
	template: HoganTemplates["templates/todo/todo"]

	events:
		"click .text-input-link": "showTitleEdit"
		"click .js-text-input-close-link": "closeTitleEdit"
		"click .todo-checkbox": "toggleDone"
		"keydown .text-input input": "updateTitle"

	initialize: (o)->
		super(o)

		@model.on
			"sync": @synced

	remove: ->
		@model.off()
		super()

	render: ( update = false )->
		if update
			$rendered = $( @template.render( @model.toJSON() ) )
			@$el.html $rendered.children()
		else
			@$el.append( @template.render( @model.toJSON() ) )
			@setElement "#todo_#{@model.get('id')}"


	updateTitle: (e)->
		if e.keyCode is 13
			e.stopPropagation()
			e.preventDefault()
			target = e.target
			title = $(target).val()
			console.info "updateTitle"
			@model.save( { title: title }, { patch: true } )

	showTitleEdit: =>
		@$(".text-input").show()
		@$(".text-input-link").hide()
		@$(".js-todo-control").hide()

	closeTitleEdit: =>
		@$(".text-input").hide()
		@$(".text-input-link").show()
		@$(".js-todo-control").show()

	toggleDone: (e)->
		$target = $( e.target )
		checked = if $target.hasClass( UNCHECKED_CLASS ) then 1 else 0
		@model.save( { done: checked }, {patch: true} )

	synced: (model)=>
		doned = false
		console.info model.changed
		for key, val of model.changed
			switch key
				when "done"
					@$el.toggleClass("done")
					@render( update: true )
					doned = true
				when "title"
					title = model.get("text")
					@$(".text-input-link").html title
					@$(".text-input").val title
		@$el.effect "highlight"
		@closeTitleEdit()
		console.info "doned", doned
		@trigger "update:checked" if doned

