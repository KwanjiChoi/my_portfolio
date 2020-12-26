class AddNameToPrefectures < ActiveRecord::Migration[6.0]
  def change
    add_column :prefectures, :name, :string, null: false
  end
end
