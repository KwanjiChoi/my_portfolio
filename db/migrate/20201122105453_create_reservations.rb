class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.references :project, null: false, foreign_key: true, index: true
      t.integer :requester_id, index: true

      t.timestamps
    end
  end
end
