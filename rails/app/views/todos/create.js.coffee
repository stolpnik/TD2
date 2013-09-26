$("#todo-list").effect("highlight", 500)
$("#todo-list").append( '<%= escape_javascript( render partial: 'list', locals: { todo: @todo } ) %>' )