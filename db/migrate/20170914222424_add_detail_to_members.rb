class AddDetailToMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :members, :user_id, :string
    add_column :members, :group_id, :string
  end
end
