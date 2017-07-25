$(document).on("turbolinks:load", function(){
  $('.datetimepicker_cell').datetimepicker({
    locale: 'ja',
    useCurrent: false
  });
  $('.hidden_field').datetimepicker({
    locale: 'ja',
    useCurrent: false
  });
  $('.btn_day_change').on('click', function(){
    var a = $(this).parent().attr("blog_id");
    $(this).hide();
    $("#hidden_field_"+a).show();
    $("#publish_time_"+a).hide();
  })
  $('.datetimepicker_cell').on('dp.change', function(data){
    var a = $(this).parent().attr("blog_id");
    $(".bootstrap-datetimepicker-widget").hide();
    $("#publish_time_"+a).html(data.date.format("Y年MM月D日 hh:mm"));
        $("#btn_day_change_"+a).show();
        $("#hidden_field_"+a).hide();
        $("#publish_time_"+a).show();
    $.ajax({
      url: '/admin/blogs/'+a,
      dataType: 'script',
      method: "patch",
      data: {redirect_check: 1, blog:{publish: data.date.format("Y-MM-D hh:mm") }},
      success: function(){
        
      }
    });
  });

  $(".published_button").on("click", function(){
    var a = $(this).parent().attr("blog_id");
    var b = $(this).attr("publish_val");
    
    if (b == "published")
    {
      $("#unpublished_button_" + a).show();
      $("#published_button_" + a).hide();
      $("#published_blog_" + a).html("公開");
    }else{
      $("#unpublished_button_" + a).hide();
      $("#published_button_" + a).show();
      $("#published_blog_" + a).html("非公開");
    }

    $.ajax({
      url: '/admin/blogs/'+a,
      dataType: 'script',
      method: 'patch',
      data: {redirect_check: 1, blog:{published: b}},
      success: function(){
        
      }
    });
  });

  $(function() {
      var imagesPreview = function(input, placeToInsertImagePreview) {

          if (input.files) {
              var filesAmount = input.files.length;

              for (i = 0; i < filesAmount; i++) {
                  var reader = new FileReader();

                  reader.onload = function(event) {
                      $($.parseHTML('<img>')).attr('src', event.target.result).appendTo(placeToInsertImagePreview);
                  }

                  reader.readAsDataURL(input.files[i]);
              }
          }

      };

      $('#blog_image').on('change', function() {
          $('div.gallery').empty();
          imagesPreview(this, 'div.gallery');
      });
      $('#author_avatar_image').on('change', function() {
          $('div.author_avatar_gallery').empty();
          imagesPreview(this, 'div.author_avatar_gallery');
      });
  });

  $("#btn_comment").on("click", function(){
    if ($("textarea").val().length == 0) {
      $("#new_comment").submit(function(e){
        e.preventDefault();
        return false;
      });
    }else{
      $("#new_comment").unbind().submit();
    };
  });
  
});
