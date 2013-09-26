class Stodo.views.ViewBase extends Backbone.View
	constructor: (o)->
		super(o)
		@router = o.router if o.router

	serializeToObject: ($form)->
		params = {}
		_.each( $form.serializeArray(),
			(obj)->
				params[obj.name] = obj.value
		)
		return params
