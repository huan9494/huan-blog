class CreateBlogUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :blog_users do |t|
      t.integer :action
      t.references :user, foreign_key: true
      t.references :blog, foreign_key: true

      t.timestamps
    end
  end
end
