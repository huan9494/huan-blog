// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require moment
//= require bootstrap-datetimepicker
//= require moment/ja
//= require turbolinks
//= require ckeditor/init
//= require ckeditor/config
//= require ckeditor/plugins/widget/plugin
//= require ckeditor/plugins/html5video/plugin
//= require slick.min
//= require_tree .
$(document).on("turbolinks:load", function(){
  $("#publish_field").datetimepicker(
    {
      locale: 'ja',
      useCurrent: false,
      format: 'Y-MM-D hh:mm'
    });

  $("#preview").on("click", function(ev){
    var content = CKEDITOR.instances['body_text'].getData();
    $("#modal_content_body").html(content);
    $("#myModal").modal();
    $('#myModal').on('hidden.bs.modal', function(){
      $("video").each(function () { this.pause() });
    });
    ev.preventDefault();
  });
  
  if ($('#infinite-scrolling-user').size() > 0) {
    $(window).on("scroll", function(){
      var more_blogs_user = $('.pagination .next_page a').attr('href');
      if (more_blogs_user && $(window).scrollTop() > $(document).height() - $(window).height() - 100) {
        $('.pagination').html('<i class="fa fa-spinner fa-spin" style="font-size:40px; color: black;"></i>');
        $.getScript(more_blogs_user);
      }
      
    });
  }

  $(".footer-menu").on("click", function(){
    $(".footer-menu").removeClass("active");
    $(this).addClass("active");
  });

  $("#back_button").on("click", function(){
    window.history.back();
  });

  $('.autoplay').slick({
    slidesToShow: 3,
    autoplay: true,
    autoplaySpeed: 2000,
  });

  $('.menu-bar ul button').hide();
});
