class AddInfoColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :major, :string
    add_column :users, :minor, :string
    add_column :users, :name, :string
    add_column :users, :graduating_year, :integer
    add_column :users, :gpa, :float
    add_column :users, :website, :string
    add_column :users, :position, :string
  end
end
