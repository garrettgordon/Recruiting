class Event < ActiveRecord::Base
	#belongs_to :organization
	has_and_belongs_to_many :users
	has_and_belongs_to_many :organizations

	MAX_NAME_LENGTH = 128
	MAX_LOCATION_LENGTH = 128
	MAX_DESCRIPTION_LENGTH = 512


	validates :name, :presence => true, :length => {maximum: MAX_NAME_LENGTH}
	validates :location, :presence => true, :length => {maximum: MAX_LOCATION_LENGTH}
	validates :description, :length => {maximum: MAX_DESCRIPTION_LENGTH}
	validates :date, :presence => true 

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
	#def self.AddEvent(dict)
	#end


	# creates and relationship between a user and event (self)
	# Event.AddUserAttending(user)
	# def AddUser(user_id)
	# 	user = User.find_by_id(user_id)
	# 	if user.kind_of?(User) and not user.nil?
	# 		begin
	# 			self.users << user
	# 			return 1
	# 		rescue
	# 			return -1
	# 		end
	# 	else
	# 		return -1
	# 	end
	# end

	# removes a relationship between a user and event
	# Event.DeleteUserAttending(user)
	# def DeleteUser(user)
	# 	if user.kind_of?(User)
	# 		begin
	# 			self.users.delete(user)
	# 			return 1
	# 		rescue
	# 			return -1
	# 		end
	# 	else
	# 		return -1
	# 	end
	# end

	# creates a relationship between an event and recruiter
	# def AddRecruiter(user_id)
	# end

	# removes relationship between event and recruiter
	# def DeleteRecruiter(user_id)
	# end

	# creates a relationship between an event and an organization
	# def AddOrganization(organization)
	# 	if organization.kind_of?(Organization)
	# 		begin
	# 			self.organizations << organization
	# 			return 1
	# 		rescue
	# 			return -1
	# 		end
	# 	else
	# 		return -1
	# 	end
	# end

	# removes organization relationship with event
	# def DeleteOrganization(organization)
	# 	if organization.kind_of?(Organization)
	# 		begin
	# 			self.organizations.delete(organization)
	# 			return 1
	# 		rescue
	# 			return -1
	# 		end
	# 	else
	# 		return -1
	# 	end
	# end


end