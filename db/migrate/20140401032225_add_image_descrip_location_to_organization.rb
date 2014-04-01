class AddImageDescripLocationToOrganization < ActiveRecord::Migration
  def self.up
  	add_column :organizations, :image, :string
  	add_column :organizations, :description, :string
  	add_column :organizations, :location, :string
  end

  def self.down
  	remove_column :organizations, :image
  	remove_column :organizations, :description
  	remove_column :organizations, :location
  end
end
