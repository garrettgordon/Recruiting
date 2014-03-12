class Event < ActiveRecord::Base
	#belongs_to :organization
	has_and_belongs_to_many :users

	# deletes event with :id, returns 1 if successful delete otherwsie -1
	# Event.DeleteEvent(id)
	def self.DeleteEvent(id)
		event = Event.find_by_id(id)
		begin
			event.delete
			return 1
		rescue
			return -1
		end
	end


	# addes event with given input
	def self.AddEvent(dict)
	end


	# creates and relationship between a user and event
	# Event.AddUserAttending(user_id,event_id)
	def self.AddUserAttending(user_id,event_id)
		event = Event.find_by_id(event_id)
		user = User.find_by_id(user_id)
		begin
			event.users << user
			return 1
		rescue
			return -1
		end
	end

	# removes a relationship between a user and event
	# Event.DeleteUserAttending(user_id,event_id)
	def self.DeleteUserAttending(user_id,event_id)
		event = Event.find_by_id(event_id)
		user = User.find_by_id(user_id)
	end



end
