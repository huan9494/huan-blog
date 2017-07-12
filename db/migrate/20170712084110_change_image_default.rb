class ChangeImageDefault < ActiveRecord::Migration[5.0]
  def change
    change_column :blogs, :image, :string, default: ''
    change_column :blogs, :author_avatar, :string, default: ''
  end
end
