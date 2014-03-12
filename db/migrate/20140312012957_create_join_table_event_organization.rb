class CreateJoinTableEventOrganization < ActiveRecord::Migration
  def change
    create_join_table :events, :organizations do |t|
      # t.index [:event_id, :user_id]
      # t.index [:user_id, :event_id]
    	t.integer :event_id
    	t.integer :organization_id
    end
  end
end
