class RemoveColumnFromCommets < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :comments, :users
    remove_reference :comments, :user, index: true
  end
end
