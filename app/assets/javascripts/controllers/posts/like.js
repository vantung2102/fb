function Like(options) {
  var module = this;
  var defaults = {
    template: {},
    container: {},
    api: {
      post: "api/v1/post/like",
    },
    data: {},
  };
  module.settings = $.extend({}, defaults, options);

  module.handleLike = function () {
    $(".like__post").on("click", function () {
      const btnLike = $(this);
      const idPost = btnLike.closest(".form_edit").attr("id");
      $.ajax({
        url: module.settings.api.post,
        type: "GET",
        data: { idPost: idPost },
        dataType: "json",
        success: function (res) {
          if (res.code == 200) {
            btnLike.toggleClass("red");
          } else {
            debugger;
          }
        },
        error: function (res) {
          console.log(res);
        },
      });
    });
  };

  module.init = function () {
    module.handleLike();
  };
}

$(document).ready(function () {
  like = new Like();
  like.init();
});
