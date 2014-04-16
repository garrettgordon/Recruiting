class AddOrganizationIdToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :organization_id, :integer
  end
end
