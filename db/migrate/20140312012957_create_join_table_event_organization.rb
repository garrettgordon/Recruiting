class CreateJoinTableEventOrganization < ActiveRecord::Migration
  def change
    create_join_table :events, :organizations do |t|
      #t.index [:user_id, :event_id]
    	t.integer :event_id
    	t.integer :organization_id
    end
    add_index :events_organizations, [:event_id, :organization_id], :unique => true, :name => 'by_event_and_organization'
  end
end
