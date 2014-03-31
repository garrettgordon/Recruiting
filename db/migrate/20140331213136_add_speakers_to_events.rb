class AddSpeakersToEvents < ActiveRecord::Migration
  def change
    add_column :events, :speakers, :string
  end
end
