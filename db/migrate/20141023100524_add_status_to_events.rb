# db/migrate/20110519123819_add_status_to_events.rb
class AddStatusToEvents < ActiveRecord::Migration
  def change
    add_column :events, :status, :string
  end
end
