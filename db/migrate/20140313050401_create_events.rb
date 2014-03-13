class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      # attribrutes shared by all events
      t.string :name
      t.string :location
      t.timestamp :date
      t.string :description
      t.string :link
      t.string :type

      t.timestamps

      # infosession specific
      t.boolean :foodPresent
      t.boolean :acceptinResumes

      # speaker panel specific
      t.integer :numberOfSpeakers

      # career fair specific
      t.integer :numberOfOrganizers
      t.string :resumeCollection
    end
  end
end
