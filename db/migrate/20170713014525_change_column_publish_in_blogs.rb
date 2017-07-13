class ChangeColumnPublishInBlogs < ActiveRecord::Migration[5.0]
  def change
    change_column :blogs, :publish, :date
  end
end
