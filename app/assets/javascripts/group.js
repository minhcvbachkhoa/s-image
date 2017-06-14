document.addEventListener('turbolinks:load', function() {
  $('.cover-file-field').change(function() {
    readURL(this, '.group-cover-edit');
  });

  function readURL(input, class_img) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $(class_img).attr('src', e.target.result);
      };
      reader.readAsDataURL(input.files[0]);
    }
  }
});

$(document).on({
  mouseenter: function () {
    $('.group-cover-update-text').show();
  },

  mouseleave: function () {
    $('.group-cover-update-text').hide();
  }
}, '.group-images .group-cover');

$(document).on('click', '.group-avatar-update-text', function() {});
