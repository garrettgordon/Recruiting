class CreateJoinTableEventUser < ActiveRecord::Migration
  def change
    create_join_table :events, :users do |t|
      
      # t.index [:user_id, :event_id]
    	t.integer :event_id
    	t.integer :user_id
    end
    add_index :events_users, [:event_id, :user_id], :unique => true, :name => 'by_event_and_user'
  end
end
