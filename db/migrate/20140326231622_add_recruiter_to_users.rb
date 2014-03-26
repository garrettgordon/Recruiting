class AddRecruiterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :recruiter, :boolean
  end
end
