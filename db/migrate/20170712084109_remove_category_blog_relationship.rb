class RemoveCategoryBlogRelationship < ActiveRecord::Migration[5.0]
  def change
    remove_column :blogs, :category_id, :integer
    add_column :blogs, :category, :string
  end
end
