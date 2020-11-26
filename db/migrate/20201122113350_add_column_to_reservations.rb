class AddColumnToReservations < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :status, :integer, default: 0, index: true
    add_column :reservations, :request_text, :text
    add_column :reservations, :start_at, :datetime
    add_column :reservations, :end_at, :datetime
  end
end
