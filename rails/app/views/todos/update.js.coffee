$("#todo_<%= @todo.id %>").effect("highlight", 500)
<% if @todo_params[:done] %>
<% if @todo.done %>
.addClass( "todo-done" )
.find( ".js-todo-checked-at" ).show()
<% else %>
.removeClass( "todo-done" )
.find( ".js-todo-checked-at" ).hide()
<% end %>
<% end %>

<% if @todo_params[:title] %>
$("#todo_<%= @todo.id %>").find(".text-input-link").html( "<%= @todo.title %>" )
<% end %>