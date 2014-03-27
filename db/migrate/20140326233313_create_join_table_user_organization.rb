class CreateJoinTableUserOrganization < ActiveRecord::Migration
  def change
    create_join_table :organizations, :users do |t|
      # t.index [:user_id, :organization_id]
      # t.index [:organization_id, :user_id]
      t.integer :organization_id
      t.integer :user_id
    end
    add_index :organizations_users, [:organization_id, :user_id], :unique => true, :name => 'by_organization_and_user'
  end
end
