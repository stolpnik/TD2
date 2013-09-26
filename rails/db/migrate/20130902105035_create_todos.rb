class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string      :title
      t.boolean     :done
      t.datetime    :checked_at
      t.integer     :position

      t.datetime    :start_at
      t.datetime    :finish_at
      t.belongs_to  :list

      t.timestamps
    end
  end
end
