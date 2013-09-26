class Stodo.routers.ListRouter extends Backbone.Router
	constructor: ->
		super()
		@lists = new Stodo.collections.ListCollection()
		Stodo.app.list = {
			'index'   : new Stodo.views.list.IndexView( collection: @lists, router: this )
			'new'     : new Stodo.views.list.NewView( collection: @lists, router: this )
		}
		Stodo.app.todo = {
			'index'   : new Stodo.views.todo.IndexView( router: this )
			'new'     : new Stodo.views.todo.NewView( router: this )
		}
		@views = Stodo.app.list
		@todoViews = Stodo.app.todo

	routes:
		'new'             : 'new'
		'index'           : 'index'
		':id/todos/new'   : 'todosNew'
		':id/todos'       : 'todosIndex'
		".*"              : 'index'

	index: ->
		@view = @views['index']
		@view.init()

	new: ->
		@view = @views['new']
		@view.render()

	todosIndex: (id)->
		@view = @todoViews['index']
		@view.init( id )

	todosNew: (id)->
		@view = @todoViews['new']
		@view.render( id )
