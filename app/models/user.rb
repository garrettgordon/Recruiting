class User < ActiveRecord::Base
	has_and_belongs_to_many :events
	acts_as_authentic

end
