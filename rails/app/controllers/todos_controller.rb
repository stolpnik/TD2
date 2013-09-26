class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy]

  # GET /todos
  # GET /todos.json
  def index
		@list = current_user.lists.find(params[:list_id])
    @todos = @list.todos
  end

  # GET /todos/1
  # GET /todos/1.json
  def show
  end

  # GET /todos/new
  def new
    @todo = current_user.lists.find(params[:list_id]).todos.new()
  end

  # GET /todos/1/edit
  def edit
  end

  # POST /todos
  # POST /todos.json
  def create
	  @list = current_user.lists.find(params[:list_id])
    @todo = @list.todos.new(todo_params)
    respond_to do |format|
      if @todo.save
	      @todo.move_to_top
        format.html { redirect_to list_todos_path, notice: 'Todo was successfully created.' }
        format.json { render action: 'show', status: :created, location: [@list, @todo] }
				#format.js { render template: "todos/create.json.erb" }
				format.js { render json: { element: render_to_string( partial: 'list', locals: { todo: @todo } ) } }
      else
        format.html { render action: 'new' }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todos/1
  # PATCH/PUT /todos/1.json
  def update
    respond_to do |format|
	    @todo_params = todo_params
      if @todo.update(@todo_params)
	      if @todo_params.has_key?(:done)
					if @todo_params[:done] === 1
	          @todo.move_to_bottom
					elsif @todo_params[:done] === 0
						@todo.move_to_top
					end
				end
        format.html { redirect_to list_todos_path, notice: 'Todo was successfully updated.' }
        format.json { render action: 'show', status: :accepted, location: [@list, @todo] }
				format.js #{ render template: "todos/update.js.coffee" }
      else
        format.html { render action: 'edit' }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    @todo.destroy
    respond_to do |format|
      format.html { redirect_to [@todo.list, @todo] }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
			@list = current_user.lists.find(params[:list_id])
      @todo = @list.todos.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def todo_params
      ret_params = params.require(:todo).permit(:title, :done, :list_id, :position, :start_at, :finish_at)
      done = ret_params[:done]
      if done === true
	      ret_params[:checked_at] = DateTime.now
      elsif done === false
				ret_params[:checked_at] = nil
      end
			ret_params
    end
end
