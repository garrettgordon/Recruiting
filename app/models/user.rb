class User < ActiveRecord::Base
	has_attached_file :picture,
	 :storage => :dropbox,
	:dropbox_credentials => "#{Rails.root}/config/dropbox_config.yml",
	 # :styles => { :medium => "300x300" , :thumb => "100x100>"},    
	:dropbox_options => {       
		:path => proc { |style| "#{style}/#{id}_#{picture.original_filename}"},
		:unique_filename => true
	 }

	 has_attached_file :resume,
	 :storage => :dropbox,
	:dropbox_credentials => "#{Rails.root}/config/dropbox_config.yml",
	:dropbox_options => {
		:path => proc { |style| "#{style}/#{id}_#{resume.original_filename}"},       
		:unique_filename => true
	 }

	validates_attachment_content_type :picture, :content_type => ["image/jpg", "image/jpeg", "image/png", "application/pdf"]
	validates_attachment_content_type :resume, :content_type => ["application/pdf"]

	has_and_belongs_to_many :events
	has_and_belongs_to_many :organizations
	has_many :jobapps
	has_many :jobs, through: :jobapps

	acts_as_taggable_on :skills, :courses

	include PgSearch
	pg_search_scope :search,
									:against => [:name],
									:associated_against => {
										:skills => [:name],
										:courses => [:name]
									},
									:using => {
										:tsearch => {prefix:true, dictionary:'english'}
									}

	acts_as_authentic do |config|
		config.perishable_token_valid_for = 1.hour
	end


	def deliver_verification_instructions!
		reset_perishable_token!
		Notifier.verification_instructions(self).deliver!
	end

	def verify!
		self.verified = true
		self.save
	end

	def applyToJob(jid)
		jb=Job.find(jid)
		if jb.nil?
			return false
		elsif self.jobs.include?(jb)
			return false
		end
		self.jobs << jb
		ja=Jobapp.find_by_user_id_and_job_id(self[:id], jb[:id])
		if ja.nil?
			return false
		end
		ja.status=0
		return self.jobs.include?(jb)
	end

	
end
