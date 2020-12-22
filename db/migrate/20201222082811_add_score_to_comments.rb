class AddScoreToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :score, :integer, null: false
  end
end
