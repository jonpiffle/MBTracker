class CreateTrackers < ActiveRecord::Migration
  def change
    create_table :trackers do |t|
      t.datetime :first_unavailable_at

      t.timestamps
    end
  end
end
