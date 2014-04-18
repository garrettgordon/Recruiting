class Organization < ActiveRecord::Base
	has_and_belongs_to_many :events
	has_and_belongs_to_many :users
	has_many :jobs
	MAX_NAME_LENGTH = 128
	validates :name, :presence => true, :length => {maximum: MAX_NAME_LENGTH}

	include PgSearch
    multisearchable :against => [:name],
                    :using => {
                        :tsearch => { prefix: true, dictionary: "english"}
                    }
	pg_search_scope :search, :against => [:name],
					:using => {
                    	:tsearch => {prefix: true, dictionary: "english"}
                  	}

    def self.text_search(query)
    	if query.present?
    		search(query)
    	else
    		scoped
    	end
    end
end
