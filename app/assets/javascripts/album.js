$(document).on({
  mouseenter: function () {
    $('.album-update-text').show();
  },

  mouseleave: function () {
    $('.album-update-text').hide();
  }
}, '.show-album .album-name');
