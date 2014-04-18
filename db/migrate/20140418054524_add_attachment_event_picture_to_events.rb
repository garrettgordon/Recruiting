class AddAttachmentEventPictureToEvents < ActiveRecord::Migration
  def self.up
    change_table :events do |t|
      t.attachment :event_picture
    end
  end

  def self.down
    drop_attached_file :events, :event_picture
  end
end
