class User < ActiveRecord::Base
	has_and_belongs_to_many :events
	has_and_belongs_to_many :organizations
	acts_as_authentic

end
