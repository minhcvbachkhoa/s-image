class AddAvatarAndCoverToGroup < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :avatar, :string
    add_column :groups, :cover, :string
  end
end
