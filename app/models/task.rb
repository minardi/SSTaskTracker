class Task < ActiveRecord::Base
	belongs_to :story
	belongs_to :sprint
end
