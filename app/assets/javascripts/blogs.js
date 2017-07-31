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
    $("#hidden_field_"+a).focus();
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

      $('#image_upload').on('change', function() {
          $('div.gallery').empty();
          imagesPreview(this, 'div.gallery');
      });
      $('#author_avatar_upload').on('change', function() {
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
  
  $("#btn_commit").on("click", function(){
    var data_valid = true;

    $("#title_error").html("");
    $("#publish_error").html("");
    $("#image_error").html("");
    $("#body_error").html("");
    $("#author_name_error").html("");
    $("#author_position_error").html("");
    $("#author_age_error").html("");
    $("#author_avatar_error").html("");

    var title_val = $("#title_field").val();
    if (title_val) {
      if (title_val.length > 255) {
        $("#title_error").html("255文字以内で入カしてください。");
        data_valid = false;
      }
    }else {
      $("#title_error").html("タイトルを入カしてください。");
      data_valid = false;
    };

    var publish_val = $("#publish_field").val();
    if (!publish_val) {
      $("#publish_error").html("公開日時を設定して下さい。");
      data_valid = false;
    };

    var fileExtension = ['jpeg', 'png'];
    if ($("#image_upload").val()) {
      if ($.inArray($("#image_upload").val().split('.').pop().toLowerCase(), fileExtension) == -1) {
        $("#image_error").html("不正なファイル形式です。<br>");
        data_valid = false;
      };
      var inpFiles = document.getElementById('image_upload');
      if (inpFiles.files.item(0).size > 2048000) {
        $("#image_error").append(" ファイルサイズは２MB以内です。");
        data_valid = false;
      };
    }

    var body_val = CKEDITOR.instances['body_text'].getData();
    if (body_val) {
      if (body_val.size > 2048000) {
        $("#body_error").html(" less than 2MB ");
        data_valid = false;
      }
    } else {
      $("#body_error").html("名前を入カしてください。");
      data_valid = false;
    };

    var author_name_val = $("#author_name_field").val();
    if (author_name_val) {
      if (author_name_val.length > 32) {
        $("#author_name_error").html("32文字以内で入カしてください。");
        data_valid = false;
      }
    } else {
      $("#author_name_error").html("名前を入カしてください。");
      data_valid = false;
    };

    var author_position_val = $("#author_position_field").val();
    if (author_position_val) {
      if (author_position_val.length > 32) {
        $("#author_position_error").html("32文字以内で入カしてください。");
        data_valid = false;
      }
    } else {
      $("#author_position_error").html("職業を入カしてください。");
      data_valid = false;
    };

    var author_age_val = $("#author_age_field").val();
    if (author_age_val) {
      if (author_age_val >= 100 || author_age_val <= 0) {
        $("#author_age_error").html("greater than 0 and less than 100");
        data_valid = false;
      }
    } else {
      $("#author_age_error").html("must have");
      data_valid = false
    };

    var fileExtension = ['jpeg', 'png'];
    if ($("#author_avatar_upload").val()) {
      if ($.inArray($("#author_avatar_upload").val().split('.').pop().toLowerCase(), fileExtension) == -1) {
        $("#author_avatar_error").html("不正なファイル形式です。");
        data_valid = false;
      };
      var authorinpFiles = document.getElementById('author_avatar_upload');
      if (authorinpFiles.files.item(0).size > 2048000) {
        $("#author_avatar_error").append(" ファイルサイズは２MB以内です。");
        data_valid = false;
      };
    }

    if (data_valid == false) {
        $("#blog_form").submit(function(e){
          e.preventDefault();
          return false;
      });
    }else{
      $("#blog_form").unbind().submit();
    };
  });

  

});
