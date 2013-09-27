#=require ./view_base

class Stodo.views.AlertView extends Stodo.views.ViewBase
	el:           "#contents"
	template:     HoganTemplates["templates/common/alert"]

	events:
		"click .btn-primary": "ok"

	constructor: (o)->
		super(o)

	render: ->
		return if @rendered
		@rendered = true
		@$el.append @template.render(
			title: @title
			text: @text
			okBtnText: @okBtnText
			cancelBtnText: @cancelBtnText
		)
		@setElement "#delete-caution"

	show: ->
		@render()
		@$el.modal( "show" )

	hide: ->
		@$el.modal( "hide" )

	ok: ->
		@trigger "ok"