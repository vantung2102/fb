function Comment(options) {
  const ENTER = 13;

  var module = this;
  var defaults = {
    template: {
      list_item: $("#comment-list-item-template"),
    },
    container: $(".list-comment"),
    api: {
      new: "/api/v1/post/comment",
      delete: "/api/v1/post/comment/destroy",
    },
    data: {},
  };

  module.settings = $.extend({}, defaults, options);

  module.handleShowInput = function () {
    $(".btn-comment").on("click", function () {
      const input_comment = $(this).closest("li").find(".input_comment");
      $(input_comment).toggle();
    });
  };

  module.handleCreate = function () {
    $(".load_comment").keypress(function (e) {
      if (e.keyCode === ENTER) {
        e.preventDefault();
        const inputComment = $(this);
        const content = $(inputComment).val();
        const parent = $(inputComment).closest("li");
        const idPost = $(parent).attr("id").split("-")[1];

        $.ajax({
          url: module.settings.api.new,
          type: "POST",
          beforeSend: function (xhr) {
            xhr.setRequestHeader(
              "X-CSRF-Token",
              $('meta[name="csrf-token"]').attr("content")
            );
          },
          data: {
            content: content,
            idPost: idPost,
          },
          dataType: "json",

          success: function (res) {
            if (res.code == 200) {
              // let template_comment = Handlebars.compile(
              //   module.settings.template.list_item.html()
              // );
              // $(parent)
              //   .find(".list-comment")
              //   .append(
              //     template_comment({
              //       comment: res.data,
              //     })
              //   );
              $(inputComment).val("");
              toastr.success("Create Comment Successfully");
            } else {
              toastr.error("Create Comment failure");
            }
          },
          error: function (res) {
            console.log(res);
          },
        });
      }
    });
  };

  module.handleDelete = function () {
    $(document).on("click", ".delete__comment", function () {
      const btnDelete = $(this);
      const itemComment = $(btnDelete).closest(".comment_item");
      const idComment = itemComment.attr("id");

      $.confirm({
        title: "Confirm!",
        content: "Delete Comment",
        buttons: {
          confirm: function () {
            $.ajax({
              url: module.settings.api.delete,
              type: "DELETE",
              data: { idComment: idComment },
              beforeSend: function (xhr) {
                xhr.setRequestHeader(
                  "X-CSRF-Token",
                  $('meta[name="csrf-token"]').attr("content")
                );
              },
              dataType: "json",
              success: function (res) {
                if (res.code == 200) {
                } else {
                }
              },
              error: function (res) {
                console.log(res);
              },
            });
          },
          cancel: function () {},
        },
      });
    });
  };

  module.init = function () {
    module.handleShowInput();
    module.handleCreate();
    module.handleDelete();
  };
}

$(document).ready(function () {
  comment = new Comment();
  comment.init();
});
