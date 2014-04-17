class User < ActiveRecord::Base
	has_attached_file :picture,
	 :storage => :dropbox,
	:dropbox_credentials => "#{Rails.root}/config/dropbox_config.yml",
	 # :styles => { :medium => "300x300" , :thumb => "100x100>"},    
	:dropbox_options => {       
		:path => proc { |style| "#{style}/#{id}_#{picture.original_filename}"},
		:unique_filename => true
	  }

	validates_attachment_content_type :picture, :content_type => ["image/jpg", "image/jpeg", "image/png", "application/pdf"]

	has_and_belongs_to_many :events
	has_and_belongs_to_many :organizations
	has_many :jobapps
	has_many :jobs, through: :jobapps
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
end
