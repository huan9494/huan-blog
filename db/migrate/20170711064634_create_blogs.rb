class CreateBlogs < ActiveRecord::Migration[5.0]
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :body
      t.integer :published, default: 0
      t.integer :promoted, default: 0
      t.datetime :publish
      t.string :image
      t.references :category, foreign_key: true
      t.string :author_name, default: "ナルフォード"
      t.string :author_position, default: "塾講師"
      t.integer :author_age, default: 26
      t.string :author_avatar
      t.integer :biglikes_count, null: false, default: 0
      t.integer :likes_count, null: false, default: 0
      t.integer :dislikes_count, null: false, default: 0
      t.integer :bigdislikes_count, null: false, default: 0

      t.timestamps
    end
  end
end
