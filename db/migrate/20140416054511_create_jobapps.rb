class CreateJobapps < ActiveRecord::Migration
  def change
    create_table :jobapps do |t|
      t.integer :status
      t.integer :user_id
      t.integer :job_id
      t.timestamps
    end
  end
end
