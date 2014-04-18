class Organization < ActiveRecord::Base
    has_attached_file :organization_picture,
        :storage => :dropbox,
        :dropbox_credentials => "#{Rails.root}/config/dropbox_config.yml",
        :dropbox_options => {
            :path => proc { |style| "#{style}/organization/images/#{id}_#{organization_picture.original_filename}"},
            :unique_filename => true
        }

    validates_attachment_content_type :organization_picture, :content_type => ["image/jpg", "image/jpeg", "image/png"]

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
