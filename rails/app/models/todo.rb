class Todo < ActiveRecord::Base
	belongs_to  :list, order: :position

	acts_as_list scope: :list

	validates   :title,
	            presence: true
end
