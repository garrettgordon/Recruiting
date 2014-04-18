class AddAttachmentOrganizationPictureToOrganizations < ActiveRecord::Migration
  def self.up
    change_table :organizations do |t|
      t.attachment :organization_picture
    end
  end

  def self.down
    drop_attached_file :organizations, :organization_picture
  end
end
