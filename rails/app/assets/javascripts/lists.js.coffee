# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#

class Stodo.app.List
	constructor: ->
		Stodo.app.router = new Stodo.routers.ListRouter()

		#start
		Backbone.history.start()
