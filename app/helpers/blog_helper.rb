require 'date'
# Helper for blog
module BlogHelper
  def custom_errors(blog)
    set_val
    blog.errors.messages.each do |msg| 

      @title_error = msg[1].last if msg[0].eql?(:title)

      @category_error = msg[1].last if msg[0].eql?(:category)

      @publish_error = msg[1].last if msg[0].eql?(:publish)

      @image_error = msg[1].last if msg[0].eql?(:image)

      @body_error = msg[1].last if msg[0].eql?(:body)

      @author_name_error = msg[1].last if msg[0].eql?(:author_name)

      @author_position_error = msg[1].last if msg[0].eql?(:author_position)

      @author_age_error = msg[1].last if msg[0].eql?(:author_age)

      @author_avatar_error = msg[1].last if msg[0].eql?(:author_avatar)
    end if blog.errors.any?
  end

  def set_val
    @title_error = ''
    @category_error = ''
    @publish_error = ''
    @image_error = ''
    @body_error = ''
    @author_name_error = ''
    @author_position_error = ''
    @author_age_error = ''
    @author_avatar_error = ''  
  end

  def category_array
    Category.cache_category
  end

  def convert_time(datetime)
    datetime.strftime('%Y年%-m月%-d日 %H:%M')
  end

  def biglikes_count(count_action)
    if count_action['biglike']
      count_action['biglike']
    else
      0
    end
  end

  def likes_count(count_action)
    if count_action['like']
      count_action['like']
    else
      0
    end
  end

  def dislikes_count(count_action)
    if count_action['dislike']
      count_action['dislike']
    else
      0
    end
  end

  def bigdislikes_count(count_action)
    if count_action['bigdislike']
      count_action['bigdislike']
    else
      0
    end
  end

end
