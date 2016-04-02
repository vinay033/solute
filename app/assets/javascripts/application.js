// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require bootstrap-datepicker
//= require select2
//= require_tree .

$(document).ready(function() {
  $("#test").select2();

  $(".btn-warning").click(function(){
    $(".form-control").val("");
  });
});
$(document).ready(function(){
  $('.datepicker').datepicker({
    format: "yyyy-mm-dd",
    showOtherMonths: true,
    selectOtherMonths: true,
    minDate: 0
  })
});

$(document).on("click", '.select_image', function(){
  $('#imageable').click();
});
function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    
    reader.onload = function (e) {
        $('#blah').css("display", "block");
        $('#blah').attr('src', e.target.result);
    }
    
    reader.readAsDataURL(input.files[0]);
  }
}
$(document).on("change", '#imageable', function(){
  readURL(this);
});



