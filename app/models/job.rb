class Job < ActiveRecord::Base
	belongs_to :organization
	has_many :jobapps
	has_many :users, through: :jobapps
	acts_as_taggable_on :skills, :courses
	MAX_NAME_LENGTH = 128
	validates :title, :presence => true, :length => {maximum: MAX_NAME_LENGTH}

	include PgSearch
	pg_search_scope :search, 
									:associated_against => {
										:skills => [:name]
									},
									:using => {
										:tsearch => { prefix: true, dictionary: 'english'}
									}

	def self.tag_search(query)
		if query.present?
			search(query)
		else
			scoped
		end
	end

	def addUser(id)
		u=User.find(id)
		if u.nil?
			return -1
		end
		self.users << u
		if self.users.last != u
			return -1
		end
		return 1
	end

	def removeUser(id)
		u=User.find(id)
		if u.nil?
			return -1
		end
		self.users.delete(u)
		if self.users.include?(u)
			return -1
		end
		return 1
	end

	def addSkillTag(str)
		if self.skill_list.include?(str)
			return 0
		end
		self.skill_list.add(str)
		if !(self.skill_list.include?(str))
			return -1
		end
		return 1
	end

	def addCourseTag(str)
		if self.course_list.include?(str)
			return 0
		end
		self.course_list.add(str)
		if !(self.course_list.include?(str))
			return -1
		end
		return 1
	end

	def removeSkillTag(str)
		if !self.skill_list.include?(str)
			return 0
		end
		self.skill_list.remove(str)
		if (self.skill_list.include?(str))
			return -1
		end
		return 1
	end

	def removeCourseTag(str)
		if !self.course_list.include?(str)
			return 0
		end
		self.course_list.remove(str)
		if (self.course_list.include?(str))
			return -1
		end
		return 1
	end

end
