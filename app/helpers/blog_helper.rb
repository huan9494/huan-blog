require 'date'
module BlogHelper
  def custom_errors(blog)
    @title_error = ''
    @category_error = ''
    @publish_error = ''
    @image_error = ''
    @body_error = ''
    @author_name_error = ''
    @author_position_error = ''
    @author_age_error = ''
    @author_avatar_error = ''
    if blog.errors.any?
      # byebug
      blog.errors.messages.each_with_index do |msg,idx|
        if msg[0].eql?(:title)
          @title_error = msg[1].last
        end
        if msg[0].eql?(:category)
          @category_error = msg[1].last
        end
        if msg[0].eql?(:publish)
          @publish_error = msg[1].last
        end
        if msg[0].eql?(:image)
          @image_error = msg[1].last
        end
        if msg[0].eql?(:body)
          @body_error = msg[1].last
        end
        if msg[0].eql?(:author_name)
          @author_name_error = msg[1].last
        end
        if msg[0].eql?(:author_position)
          @author_position_error = msg[1].last
        end
        if msg[0].eql?(:author_age)
          @author_age_error = msg[1].last
        end
        if msg[0].eql?(:author_avatar)
          @author_avatar_error = msg[1].last
        end
      end 
    end
  end
  def category_array
    Category.order("created_at ASC").pluck(:name)
  end
  def convert_time(datetime)
    datetime.strftime("%Y年%-m月%-d日 %H:%M")
  end
end