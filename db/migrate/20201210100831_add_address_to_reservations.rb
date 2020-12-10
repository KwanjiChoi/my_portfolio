class AddAddressToReservations < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :address, :string
  end
end
