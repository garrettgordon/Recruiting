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
    		Organization.all
    	end
    end

    def self.readySort(orgList)
        if orgList.nil? || orgList.length==0
            return []
        end
        newList=[]
        orgList.each do |org|
            sum=0
            jobs=org.jobs
            jobs.each do |job|
                sum += job.users.length
            end
            sum+= 10*(org.events.length)
            item=[org, sum]
            newList << item
        end
        return newList
    end

    def self.mergeSort(orgList)
        if orgList.nil? || orgList.length==0
            return []
        end
        if orgList.length==1
            return orgList
        end
        pivot=orgList.length/2
        left=orgList.slice(0, pivot)
        right=orgList.slice(pivot, orgList.length)
        left=self.mergeSort(left)
        right=self.mergeSort(right)
        newList=self.merge(left, right)
        return newList
    end

    def self.merge(left, right)
        newList=[]
        i=0
        j=0
        while (i<left.length && j<right.length) do
            if (left.at(i)).at(1) >= (right.at(j)).at(1)
                newList << left.at(i)
                i=i+1
            else
                newList << right.at(j)
                j=j+1
            end
        end

        if i<left.length
            while (i<left.length) do
                newList << left[i]
                i=i+1
            end
        else
            while (j<right.length) do
                newList << right[j]
                j=j+1
            end
        end
        return newList
    end


    def self.listConvert(orgList)
        newList=[]
        orgList.each do |org|
            newList << org[0]
        end
        return newList
    end
end
