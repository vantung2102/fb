import consumer from "../consumer";

consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    if (data.action == "create") {
      const idPost = data.comment.post_id;
      const listCommentPost = $(`#post-${idPost}`);
      const getCountComment = $(`#count_comment-${idPost}`);
      const oldCountComment = getCountComment.text().split(" ")[0];
      const newCountComment = parseInt(oldCountComment) + 1;

      getCountComment.html(`${newCountComment} Comments`);

      let template_comment = Handlebars.compile(
        $("#comment-list-item-template").html()
      );
      $(listCommentPost)
        .find(".list-comment")
        .append(
          template_comment({
            id: data.comment.id,
            content: data.comment.content,
            username: data.username,
            avatar_url: data.avatar_url,
          })
        );
    } else if (data.action == "destroy") {
      const idComment = data.destroy.id;
      const itemComment = $(`.comment_item#${idComment}`);
      const getCountComment = $(`#count_comment-${data.destroy.post_id}`);
      const oldCountComment = getCountComment.text().split(" ")[0];
      const newCountComment = parseInt(oldCountComment) - 1;

      getCountComment.html(`${newCountComment} Comments`);
      itemComment.remove();
    }
  },
});
