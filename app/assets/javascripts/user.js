document.addEventListener('turbolinks:load', function() {
  $('.avatar-file-field').change(function() {
    readURL(this, '.user-avatar-edit');
  });

  $('.cover-file-field').change(function() {
    readURL(this, '.user-cover-edit');
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
    $(this).css({'background': 'linear-gradient(transparent, rgba(0, 0, 0, .6)'
      + ' 50%, rgba(0, 0, 0, .6) 100%)'});
    $('.user-avatar-update-text').show();
  },

  mouseleave: function () {
    $(this).css({'background': 'none'});
    $(this).css({'background-color': 'white'});
    $('.user-avatar-update-text').hide();
  }
}, '.user-image .user-avatar');

$(document).on({
  mouseenter: function () {
    $('.user-cover-update-text').show();
  },

  mouseleave: function () {
    $('.user-cover-update-text').hide();
  }
}, '.user-image .user-cover');

$(document).on('click', '.user-avatar-update-text', function() {});
