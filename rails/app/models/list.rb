class List < ActiveRecord::Base
	belongs_to  :user #, order: :position
	has_many    :todos, dependent: :destroy

	validates   :title,
	            presence: true
	default_scope includes(:todos)
end
