class Organization < ActiveRecord::Base
	has_and_belongs_to_many :events
	has_and_belongs_to_many :users
	MAX_NAME_LENGTH = 128
	validates :name, :presence => true, :length => {maximum: MAX_NAME_LENGTH}
end
