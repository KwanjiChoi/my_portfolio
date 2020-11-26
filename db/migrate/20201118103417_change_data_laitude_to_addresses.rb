class ChangeDataLaitudeToAddresses < ActiveRecord::Migration[6.0]
  def change
    change_column :addresses, :latitude, :decimal, precision: 9, scale: 3
    change_column :addresses, :longitude, :decimal, precision: 9, scale: 3
  end
end
