# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
blog_arr1 = []
1000.times do |i|
  blog_arr1 << Blog.new( title: "category_1_blog_#{i}",
                        category: "category 1",
                        publish: "2017-10-6 11:10",
                        published: "published",
                        body: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")

end
Blog.import blog_arr1, validate: false
blog_arr2 = []
1000.times do |i|
  blog_arr2 << Blog.new( title: "category_2_blog_#{i}",
                        category: "category 2",
                        publish: "2017-10-6 11:10",
                        published: "published",
                        body: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")

end
Blog.import blog_arr2, validate: false
blog_arr3 = []
1000.times do |i|
  blog_arr3 << Blog.new( title: "category_3_blog_#{i}",
                        category: "category 3",
                        publish: "2017-10-6 11:10",
                        published: "published",
                        body: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")

end
Blog.import blog_arr3, validate: false
# Blog.search_index.clean_indices
# Blog.reindex(async: true)

Category.create(name: "category 1")
Category.create(name: "category 2")
Category.create(name: "category 3")