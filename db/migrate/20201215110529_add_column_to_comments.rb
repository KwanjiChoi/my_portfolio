class AddColumnToComments < ActiveRecord::Migration[6.0]
  def up
    add_column :comments, :commenter_id, :integer, null: false
  end
end
